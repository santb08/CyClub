// @packages
import 'package:cyclub/PersonalRoute.dart';
import 'package:cyclub/helpers/polylines.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// @scripts
import 'AvatarButton.dart';
import 'MenuButton.dart';
import 'dart:async';


class Map extends StatefulWidget {
  bool tracking;
  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  static const TRACKED_ROUTE_ID = "89723457647654211242443"; 

  BitmapDescriptor bitmapImage;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  LocationData currentLocation;
  Marker myLocationMarker = Marker(markerId: MarkerId("me"), position: LatLng(0, 0));
  PersonalRoute myRoute = PersonalRoute();
  Set<Polyline> _graphedPolylines = Set();
  bool _trackingMyRoute = false;
  int distance = 0;

  /*
   * initState will initialize the position of the app at user's
   * Also will get the routes from the api (TODO) and will save them to be traced in the map
   */
  @override
  initState() {
    super.initState();
    _createMarkerImageFromAsset("assets/bicycle5.png");
    _loadPolylines();
    _addLocationListener();
  }

  /*
   * This function will return an empty tracked route polyline with default ID
   */
  Polyline _getDefaultTrackingPolyline() {
    return Polyline(
        polylineId: PolylineId(TRACKED_ROUTE_ID),
        color: Colors.black,
        width: 5,
        visible: true,
        points: List<LatLng>());
  }

  void _updateMarker() {
    this.setState(() {
      myLocationMarker = Marker(
          markerId: MarkerId("MyLocationMarker"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: bitmapImage);
    });
  }

  /*
   * Gets a list of polylines, and then sets it to the state
   */
  _loadPolylines() async {
    Set<Polyline> cityRoutes = await getRoutesPolylines();
    setState(() {
      _graphedPolylines.add(_getDefaultTrackingPolyline());
      _graphedPolylines.addAll(cityRoutes);
    });
  }

  _addLocationListener() {
    location.onLocationChanged().listen((location) {
      currentLocation = location;
      _updateMarker();
      _goToMyPos();
      this.setState(() {
        // Saving my tracked coordinates
        if (_trackingMyRoute) {
          LatLng coor = LatLng(location.latitude, location.longitude);
          _graphedPolylines
              .firstWhere((polyline) => polyline.polylineId.value == TRACKED_ROUTE_ID)
              .points
              .add(coor);
        }
      });
    });
  }

  /*
   * After map's created, this handler will be executed
   * first of all, we'll get position
   * then we'll point a marker right there, and we'll move the camera to that location
   * then we'll fill the polylines for the routes
   */
  _handleMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    _getMyLocation();
  }

  _goToMyPos() {
    LatLng position = LatLng(currentLocation.latitude, currentLocation.longitude);
    goToPosition(position);
  }

  List<LatLng> getTrackedCoordinates() {
    return _graphedPolylines
        .firstWhere((polyline) => polyline.polylineId.value == TRACKED_ROUTE_ID)
        .points;
  }

  /*
   * This function will show:
   *  Coordinates of the route that user did
   *  Time that the user used in its route (TODO)
   * Also, it'll flip the tracking flag state, and it'll clean the user's route
   */
  _trackMyRouteButtonHandler() {
    if (_trackingMyRoute) {
      print(getTrackedCoordinates());
      myRoute.setCoordinates(_graphedPolylines
          .firstWhere((polyline) => polyline.polylineId.value == TRACKED_ROUTE_ID)
          .points);
      myRoute.endRoute();
      myRoute = PersonalRoute();
    }
    
    // Update state to start/stop tracking routes
    this.setState(() {
      _trackingMyRoute = !_trackingMyRoute;
      restartTrackedPolyline();
    });
  }

  /*
   * This function will find the polyline of the tracked route and it'll restart its list of points
   */
  restartTrackedPolyline() {
    _graphedPolylines
        .firstWhere((polyline) => polyline.polylineId.value == TRACKED_ROUTE_ID)
        .points
        .removeWhere((point) => point != null);
  }

  @override
  Widget build(BuildContext context) {
    return _graphedPolylines.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      bearing: 0, target: LatLng(0, 0), tilt: 45, zoom: 16),
                  compassEnabled: false,
                  onMapCreated: _handleMapCreated,
                  myLocationEnabled: true,
                  markers: Set<Marker>.from([myLocationMarker]),
                  polylines: _graphedPolylines),
              MenuButton(),
              AvatarButton(),
              Positioned(
                bottom: 70,
                right: 0,
                child: IconButton(
                    iconSize: 50,
                    icon: Icon(Icons.trip_origin),
                    onPressed: _trackMyRouteButtonHandler),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton.extended(
                  label: Text("My routes"),
                  onPressed: () { print("My routes"); },
                )
              )
            ],
          );
  }

  /*
   * According to @target it'll make the map move right here
   */
  Future<void> goToPosition(LatLng target) async {
    var cameraTarget = CameraPosition(bearing: 0, target: target, tilt: 45, zoom: 16);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraTarget));
    _updateMarker();
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    ImageConfiguration configuration = ImageConfiguration();
    bitmapImage =
        await BitmapDescriptor.fromAssetImage(configuration, iconPath);
    return bitmapImage;
  }

  /*
   * It'll get my position and it'll call goToPosition() to move came to my position
   */
  Future<void> _getMyLocation() async {
    try {
      location.changeSettings(accuracy: LocationAccuracy.HIGH);
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION DENIED") {
        print(e.code);
        location.requestPermission();
      }
    }
  }
}
