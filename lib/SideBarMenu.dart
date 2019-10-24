import 'package:flutter/material.dart';

import 'AboutUs.dart';
import 'CellphoneCall.dart';
import 'Profile.dart';

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
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              curve: Curves.easeInCirc,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/drawer_header_background.jpg')))),
          MaterialButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Profile(),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.person_pin,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child:
                      Text('Mi perfil', style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => print('amigos'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.people_outline,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child: Text('Amigos', style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => print('config'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.settings,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child: Text('Configuración',
                      style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => print('lugares'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.place,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child: Text('Lugares', style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => print('retos'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.score,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child: Text('Retos', style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => print('compartir'),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.share,
                  color: Colors.lime,
                  size: 40,
                ),
                Padding(
                  child:
                      Text('Compartir', style: TextStyle(color: Colors.black)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                )
              ],
            ),
          ),
          MaterialButton(
              color: Colors.redAccent,
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CellphoneCall(),
                    ),
                  ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.call,
                    size: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    child: Text('Llamada de emergencia'),
                  )
                ],
              )),
          ListTile(
            title: Text("Conócenos"),
            subtitle: Text('Acerca de nosotros...'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AboutUs(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
