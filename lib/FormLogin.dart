import 'package:flutter/material.dart';
import 'package:cyclub/App.dart';

//TODO: Hijueputa, comentá todo este mierdero
class FormLogin extends StatefulWidget {
  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  
  //Controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                                return (value.isEmpty) ? 'Por favor ingrese un email' : null;
                              },
                            )
                  ),
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
                        return (value.isEmpty) ? "Por favor ingrese una contraseña" : null;
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
                       if (_formKey.currentState.validate()) Navigator.push(context, new MaterialPageRoute(
                         builder: (BuildContext context) => App()

                       ));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
