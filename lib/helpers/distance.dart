import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<double> calculateDistance(LatLng pos1, LatLng pos2) async {
  double distance = await Geolocator().distanceBetween(pos1.latitude, pos1.longitude, pos2.latitude, pos2.longitude);
  return distance;
}