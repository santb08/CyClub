import 'package:cyclub/Map.dart';
import 'package:cyclub/Navbar.dart';
import 'package:cyclub/Profile.dart';
import 'package:cyclub/SideMenu.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  Widget build(BuildContext context){
    Route _createRoute() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Profile(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    return new Scaffold(
      body: Map(),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text("Mi perfil"),
              onTap:  () => Navigator.push(context, _createRoute()),
            )
          ]
        ), // appBar: SideMenu(),
      )
    );
  }
}