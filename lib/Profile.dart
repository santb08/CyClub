import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(  //I want to add many widgets here
        children: <Widget>[
          Positioned(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    image: DecorationImage(
                      image: NetworkImage("https://cdn2.thecatapi.com/images/8qf.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    boxShadow: [
                      BoxShadow(blurRadius: 15, color: Colors.black)
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
      )
    );
  }
}