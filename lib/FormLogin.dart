import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<_FormLogin>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: 140, left: 50, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Ingrese Email",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                    validator: (value) {
                      return (value.isEmpty) ? 'Ingrese email' : null;
                    },
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
                        return (value.isEmpty) ? "Ingrese Contraseña" : null;
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
                      print("esta vuelta hace algo");
                    },
                  )
                ],
              ),
            )));
  }
}
