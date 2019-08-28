import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map>{
  //Controller for Google Maps
  Completer<GoogleMapController> _controller = Completer();

  //Polylines for trace the routes
  Set<Polyline> _polylines = {};

  /**
   * initState will initialize the position of the app at user's
   * Also will get the routes from the api (TODO) and will save them to be traced in the map
   */
  @override
  initState(){
    super.initState();
    _goToMyPos();
    //TODO: Get routes and put them in the state
    _polylines.add(Polyline(
      polylineId: PolylineId('Ejemplo'),
      visible: true,
      points: [LatLng(6.23116127, -75.59998208), LatLng(6.23182977, -75.57790234)],
      width: 3,
      color: Colors.blue,
    ));
    print("EO");
  }

  //Fake data, in case location get some err(?) **Not really needed**
  static final CameraPosition _kGooglePlex = CameraPosition(
    tilt: 45,
    target: LatLng(6.229548, -75.5705),//37.42796133580664
    zoom: 14.4746,
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polylines: _polylines
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToMyPos,
        label: Text('Mi tales'),
        icon: Icon(Icons.directions_boat),
      ),
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


  /**
   * It'll get my position and it'll call goToPosition() to move came to my position
   */
  Future<void> _goToMyPos() async {
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    var currentLocation = LocationData;
    var location = new Location();
    var error;
    try {
      var currentLocation = await location.getLocation();
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      goToPosition(LatLng(currentLocation.latitude, currentLocation.longitude));
    } on PlatformException catch (e){
      if (e.code == "PERMISSION DENIED") {
        error = 'Permission denied';
        location.requestPermission();
      }
      currentLocation = null;
    }

  }
}