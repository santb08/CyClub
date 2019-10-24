import 'package:flutter/material.dart';

import 'Profile.dart';

class AvatarButton extends StatelessWidget {
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
    return Positioned(
      child: Stack(children: <Widget>[
        Positioned(
          bottom: -80,
          left: -60,
          child: Container(
            width: 225,
            height: 225,
            decoration: BoxDecoration(
              color: Colors.limeAccent
                  .withAlpha(0xBB), //I just wanted to say "Bebé" in Hex
              borderRadius: BorderRadius.all(Radius.circular(155)),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: -10,
          child: GestureDetector(
            onTap: () => Navigator.push(context, _createRoute()),
            child: Container(
              width: 167,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage("assets/Panita.png"), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
