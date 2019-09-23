import 'package:cyclub/FormLogin.dart';
import 'package:cyclub/Profile.dart';
import "package:flutter/material.dart";
  
class NavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 1.0,
      child: Row(
        children: <Widget>[
          RaisedButton(
            color: Colors.white,
            elevation: 0.0,
            child: Icon(Icons.person),
            onPressed: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Profile())),
          ),
          RaisedButton(
              color: Colors.white,
              elevation: 0.0,
              child: Icon(Icons.laptop),
              onPressed: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new FormLogin()))),
          RaisedButton(
            color: Colors.white,
            elevation: 0.0,
            child: Icon(Icons.map),
            onPressed: () => print("Cañas la vendiste muy feo 3"),
          ),
          RaisedButton(
            color: Colors.white,
            elevation: 0.0,
            child: Icon(Icons.gps_fixed),
            onPressed: () => print("Cañas la vendiste muy feo 4"),
          ),
        ],
      ),
    );
  }
}
