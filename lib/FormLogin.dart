import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cyclub/Map.dart';
class FormLogin extends StatefulWidget {
  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 160, left: 20, right: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
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
                      setState(() {
                       if (_formKey.currentState.validate()) Navigator.push(context, new MaterialPageRoute(
                         builder: (BuildContext context) => Map()
                       ));
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
