import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _username;

  @override
  void initState() {
    super.initState();

    this._loadInfo();
  }

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this._username = prefs.getString('username') ?? 'error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body: Stack(
        //I want to add many widgets here
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.limeAccent.withOpacity(0.8)),
            clipper: getClipper(),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      image: DecorationImage(
                        image: NetworkImage("https://cataas.com/cat"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: Colors.black)
                      ]),
                ),
                SizedBox(height: 30),
                Text(_username ?? 'fetchDataErr',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monserrat')),
                SizedBox(height: 15.0),
                Text(
                  'Descripción del parcero: Más haragán que 20',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 50.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  margin: EdgeInsets.zero,
                  child: Material(
                    elevation: 7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bike.png"),
                              width: MediaQuery.of(context).size.width * 0.30,
                            ),
                            Text("kms recorridos",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserrat')),
                            Text("0,0 km")
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/clock.png"),
                              width: MediaQuery.of(context).size.width * 0.30,
                            ),
                            Text("Tiempo recorridos",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserrat')),
                            Text("0a 0m 0d 0h 0m 0s")
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/calories.png"),
                              width: MediaQuery.of(context).size.width * 0.30,
                            ),
                            Text("Calorías quemadas",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monserrat')),
                            Text("0,0 cal")
                          ],
                        )
                      ],
                    ),
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
    path.lineTo(size.width, size.height);
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
