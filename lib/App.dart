import 'package:cyclub/Map.dart';
import 'package:cyclub/Navbar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  Widget build(BuildContext context){
    return new Scaffold(
      body: Map(),
      bottomNavigationBar: NavBar(),
    );
  }
}