import 'package:flutter/material.dart';

import 'SideBarMenu.dart';

class MenuButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      child: IconButton(
        splashColor: Colors.grey,
        color: Colors.black,
        tooltip: 'Menu',
        iconSize: 50,
        icon: Icon(Icons.menu),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SideBarMenu(),
          ),
        ),
      ),
    );
  }
}
