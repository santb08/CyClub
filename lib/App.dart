import 'package:cyclub/Map.dart';
import 'package:cyclub/Profile.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Profile(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget build(context) {
    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Text("Menu"),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text("Mi perfil"),
          onTap: () => Navigator.push(context, _createRoute()),
        ),
        ListTile(
          title: Text("Otra opción"),
          onTap: () => Navigator.push(context, _createRoute()),
        ),
      ]), // appBar: SideMenu(),
    );
  }
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(body: Map(), drawer: SideBarMenu());
  }
}
