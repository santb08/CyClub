import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';

class CellphoneCall extends StatelessWidget {
  TextEditingController tel = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void makeCall(String tel) {
    try {
      UrlLauncher.launch("tel://$tel");
    } catch (e) {
      print(e);
    }
  }

//TODO: Hacer que se vea alguna mierda...
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/josh-nuttall-zkVi57UYHIQ-unsplash.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LLAMADA DE EMERGENCIA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedGradientButton(
                height: 50,
                shape: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Policía       ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      Icon(
                        Icons.airport_shuttle,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                gradient: LinearGradient(
                  colors: <Color>[Colors.red, Colors.blue],
                ),
                onPressed: () => makeCall('123'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedGradientButton(
                height: 50,
                shape: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Transito      ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      Icon(Icons.airport_shuttle)
                    ],
                  ),
                ),
                gradient: LinearGradient(
                  colors: <Color>[Colors.white, Colors.blue],
                ),
                onPressed: () => makeCall('123'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: this.tel,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Ingresar un número',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.phone),
              color: Colors.green,
              onPressed: () => makeCall(this.tel.text.toString()),
            )
          ],
        ),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final ShapeBorder shape;
  const RaisedGradientButton(
      {Key key,
      @required this.child,
      this.gradient,
      this.width,
      this.height,
      this.onPressed,
      this.shape})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(gradient: gradient, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: Material(
        shape: shape,
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
