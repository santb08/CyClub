import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cyclub/App.dart';

//TODO: Hijueputa, comentá todo este mierdero

class FormLogin extends StatefulWidget {
  final bool isLoggedIn = false;

  @override
  _FormLogin createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background_login.jpg'),
          fit: BoxFit.cover
        )
      ),
      child: 
      Scaffold(
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
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              labelText: "Ingrese Email",
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.0)
                              )
                          ),
                          validator: (value) {
                            return (value.isEmpty)
                                ? 'Por favor ingrese un email'
                                : null;
                          },
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        cursorColor: Colors.white,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          labelText: "Ingrese Contraseña",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.0)
                          )  
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
                        setState(() {
                          if (_formKey.currentState.validate())
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) => App()));
                        });
                      },
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
