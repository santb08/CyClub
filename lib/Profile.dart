import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Stack(  //I want to add many widgets here
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.limeAccent.withOpacity(0.8)),
            clipper: getClipper(),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: DecorationImage(
                      image: NetworkImage("https://cdn2.thecatapi.com/images/8qf.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, color: Colors.black)
                    ]
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Lil Cool Cat",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monserrat'
                  )
                ),
                SizedBox(height: 15.0),
                Text(
                  'Descripción del parcero: Más haragán que 20',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 25.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Material(  
                    elevation: 7,
                    child: Text("Aquí va información, aún no sé qué información, pero irá información")
                    
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width * 1.2, size.height);
    path.lineTo(size.width , size.height);
    path.lineTo(0.0, size.height / 1.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}