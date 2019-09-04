import 'package:flutter/material.dart';
import 'package:cyclub/Profile.dart';
class SideMenu extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Menu"),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
              accountName: new Text("Ciclista"),
              accountEmail: new Text("ciclista@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage("https://placekitten.com/500/500"),
              ),
            ),
            new ListTile(
              title: new Text("Mi perfil"),
              onTap: () => Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new Profile()
              ),
              // onTap: () => Navigator.of(context).push(Profile()),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}