//ICONS https://www.flaticon.com/authors/freepik
import 'package:cyclub/Profile.dart';
import 'package:cyclub/helpers/polylines.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:cyclub/helpers/api.dart';
import 'package:http/http.dart' as http;

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map>{
  //Controller for Google Maps
  Completer<GoogleMapController> _controller = Completer();
  //Polylines for trace the routes
  Set<Polyline> _polylines = {};  
  var location = new Location();  //Location object for this code
  //Marker for my position
  Marker myLocation = Marker(markerId: MarkerId("me"), position: LatLng(0,0));
  bool _loadingRoutes;  //Flag for charging state: loading routes?

  //Fake data, in case location get some err(?) **Not really needed**
  static final CameraPosition _kInitial = CameraPosition(
    tilt: 45,
    target: LatLng(6.229548, -75.5705),//37.42796133580664
    zoom: 14.4746,
  );

  /**
   * initState will initialize the position of the app at user's
   * Also will get the routes from the api (TODO) and will save them to be traced in the map
   */
  @override
  initState(){
    super.initState();
    _createMarkerImageFromAsset("assets/bicycle5.png");
    _goToMyPos();
    _loadingRoutes = true;
    _loadPolylines();
    _addLocationListener();
  }
  
  _loadPolylines() async {
    Set<Polyline> pl = await getRoutesPolylines();
    setState(() {
      _polylines.addAll(pl);
      _loadingRoutes = false;
      print(_polylines);
    });
  }

  _addLocationListener() {
    location.onLocationChanged().listen(
      (location){
        setMyLocation(location);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loadingRoutes ? 
      Center(
        child: CircularProgressIndicator(),
      ) 
      :  
      Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kInitial,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            markers: Set<Marker>.from([myLocation]),
            polylines: _polylines
          ),
          Positioned(
            bottom: 250,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: ()=> print('se imprimio'),
            ),
          ),
          Positioned(
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: -80,
                  left: -60,
                  child: Container(
                    width: 225,
                    height: 225,
                    decoration: BoxDecoration(
                      color: Colors.limeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(155)),
                      boxShadow: [
                        BoxShadow(blurRadius: 25, color: Colors.black)
                      ]
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: -10,
                  child: AvatarButton()
                ),
              ]
            ),
          ),
        ],
      )
      
    );
  }

  /**
   * According to @target it'll make the map move right here
   */
  Future<void> goToPosition(target) async {
    var cameraTarget = CameraPosition(
      bearing: 0,
      target: target,
      tilt: 45,
      zoom: 16
    );
    
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraTarget));
  }

  Future <BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
      ImageConfiguration configuration = ImageConfiguration();
      bitmapImage = await BitmapDescriptor.fromAssetImage(
          configuration,iconPath);
      return bitmapImage;
    }
  
  BitmapDescriptor bitmapImage;

  setMyLocation(LocationData location){
    setState(() {
        myLocation = Marker(
          markerId: MarkerId("me"),
          position: LatLng(location.latitude, location.longitude),
          icon: bitmapImage
        );
    });
  }

  /**
   * It'll get my position and it'll call goToPosition() to move came to my position
   */
  Future<void> _goToMyPos() async {
    var currentLocation = LocationData;
    var error;
    try {
      location.changeSettings(accuracy: LocationAccuracy.HIGH);
      var currentLocation = await location.getLocation();
      setMyLocation(currentLocation);
      goToPosition(myLocation.position);
    } on PlatformException catch (e){
      if (e.code == "PERMISSION DENIED") {
        error = 'Permission denied';
        location.requestPermission();
      }
      currentLocation = null;
    }

  }
}

class AvatarButton extends StatelessWidget{
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Profile(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget build(context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, _createRoute()),
      child: Container(
        width: 167,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/Panita.png"),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}