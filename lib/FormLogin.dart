import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cyclub/pojos/User.dart';
import 'package:flutter/material.dart';
import 'package:cyclub/App.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cyclub/helpers/api.dart';
import 'package:http/http.dart';

abstract class SignInWithButton extends StatelessWidget {
  String text;
  IconData icon;

  SignInWithButton(this.text, this.icon);

  Future<User> signIn();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250.0,
        child: Align(
          alignment: Alignment.center,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Color(0xffffffff),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(this.icon, color: Color(0xffCE107C)),
                SizedBox(width: 10.0),
                Text(
                  this.text,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
            onPressed: signIn,
          ),
        ));
  }
}


class GoogleSignInButton extends SignInWithButton {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  dynamic onLoadMap;

  GoogleSignInButton({this.onLoadMap}) : super("Google", FontAwesomeIcons.google);

  _setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  _setUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  /*
   * This async function will let us sign in with google
   * implementation used in official docs.
   * After all, it'll return a FirebaseUser that's a Future than can be solved as we want
   */
  Future<User> signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final user = User(email: googleUser.email, name: googleUser.displayName);
    Response signIn = await userSignIn(user);

    //User's log in
    if (signIn.statusCode == 200) {
      var body = json.decode(signIn.body);
      print(body.toString());
      _setUserId(body['id']);
      _setUsername(body['name']);
      this.onLoadMap();
    }

    //User's sign in
    if (signIn.statusCode == 201) {
      //TODO: Redirect to fill my profile
      var body = json.decode(signIn.body);
    }
  }
}

class FacebookSignInButton extends SignInWithButton {
  FacebookSignInButton(String text, var onpressed, var icon)
      : super(text, onpressed) {
    this.icon = icon;
  }

  /*
   * This async function will let us sign in with facebook
   * implementation used in official docs.
   * After all, it'll return a FirebaseUser that's a Future than can be solved as we want
   */
  Future<User> signIn() async {
    print("Iniciando sesión con facebook");
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print("Logged as " + user.displayName);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("Error");
        break;
    }
  }
}

class FormLogin extends StatefulWidget {
  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController;

  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      .then((prefs) {
        setState(() => this._prefs = prefs);
      });
  }

  void onLoadMap() {
    print("Logged");
    setState(() {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => App()));
    });
  }

  _setUsername(String username) async {
    await this._prefs.setString('username', username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background_login.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      width: 120,
                      height: 120,
                      image: AssetImage('assets/temp.png'),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextFormField(
                          onSaved: (value) => this.setState(() {
                            _setUsername(value);
                          }),
                          cursorColor: Colors.white,
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelText: "Ingrese Usuario",
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          validator: (value) {
                            return (value.isEmpty)
                                ? 'Por favor ingrese un nombre de usuario'
                                : null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: "Ingrese Contraseña",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        validator: (value) {
                          return (value.isEmpty)
                              ? "Por favor ingrese una contraseña"
                              : null;
                        },
                      ),
                    ),
                    MaterialButton(
                      color: Colors.transparent,
                      child: Text('Ingresar'),
                      textColor: Colors.white,
                      minWidth: 150,
                      shape: StadiumBorder(),
                      onPressed: () {
                        if (_formKey.currentState.validate()) onLoadMap();
                      }
                    ),
                    GoogleSignInButton(
                      onLoadMap: onLoadMap
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
