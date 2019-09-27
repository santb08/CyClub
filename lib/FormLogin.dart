import 'package:cyclub/pojos/User.dart';
import 'package:flutter/material.dart';
import 'package:cyclub/Map.dart';
import 'package:cyclub/App.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cyclub/helpers/api.dart';
import 'package:http/http.dart';

class SignInWithButton extends StatelessWidget {
  String text;
  var onpressed;
  
  //Constructor
  SignInWithButton({this.text, this.onpressed});
  
  @override
  Widget build(BuildContext context){
    return Container(
      width: 250.0,
        child: Align(
        alignment: Alignment.center,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
          ),
          color: Color(0xffffffff),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Icon(
              FontAwesomeIcons.google,
              color: Color(0xffCE107C)
            ),
            SizedBox(width:10.0),
            Text(
              this.text,
              style: TextStyle(color: Colors.black,fontSize: 18.0),
            ),
          ],),
          onPressed: onpressed,
        ),
      )
    );
  }
}

/**
 * This component is a simple button that
 * will handle all the SignIn with Firebase through Google.
 **/ 
class GoogleSignInButton extends StatelessWidget {
  //Required variables to user GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  /**
   * This async function will let us sign in with google
   * implementation used in official docs.
   * After all, it'll return a FirebaseUser that's a Future than can be solved as we want
   *
   * @
   */
  Future<dynamic> signIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final user = User(email: googleUser.email, name: googleUser.displayName);
    Response signIn = await userSignIn(user);
    
    //User's sign in
    if(signIn.statusCode == 201) {
      //TODO: Redirect to fill my profile
    }

    //User's log in
    if (signIn.statusCode == 200) {
      
    }

    
  }


  //Return google sign in button
  Widget build(BuildContext context) => SignInWithButton(text: "Sign In With Google", onpressed: signIn);
}

class FacebookSignInButton extends StatelessWidget {
  
  /**
   * This async function will let us sign in with facebook
   * implementation used in official docs.
   * After all, it'll return a FirebaseUser that's a Future than can be solved as we want
   */
  Future<FirebaseUser> signIn() async {
    print("Iniciando sesión con facebook");
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token
    );

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        var user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
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

  Widget build(BuildContext context) => SignInWithButton(text: "Sign In With Facebook", onpressed: signIn);

}

class FormLogin extends StatefulWidget {
  final bool isLoggedIn = false;

  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    color: Colors.blueAccent,
                    width: 80,
                    height: 80,
                    image: AssetImage('assets/profile.png'),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Ingrese Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        validator: (value) {
                          return (value.isEmpty)
                              ? 'Por favor ingrese un email'
                              : null;
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Ingrese Contraseña",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      validator: (value) {
                        return (value.isEmpty)
                            ? "Por favor ingrese una contraseña"
                            : null;
                      },
                    ),
                  ),
                  MaterialButton(
                    child: Text("Ingresar"),
                    color: Colors.blueAccent,
                    shape: StadiumBorder(),
                    textColor: Colors.white,
                    minWidth: 150.0,
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState.validate())
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => App()));
                      });
                    },
                  ),
                  GoogleSignInButton(),
                  FacebookSignInButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
