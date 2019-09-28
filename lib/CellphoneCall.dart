import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';

class CellphoneCall extends StatelessWidget {


  void _makeCall(String tel) {
    try {
      UrlLauncher.launch("tel://$tel");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            MaterialButton(
              color: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 50,horizontal: 50),
              child: Text('test'),
              onPressed: () => _makeCall('123'),
            )
          ],
        ),
      ),
    );
  }
}