import 'package:cyclub/FormLogin.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyClyb Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FormLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
