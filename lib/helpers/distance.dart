import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

double calculateDistance(LatLng locationObj1, LatLng locationObj2){
    var p = 0.017453292519943295;
    var c = cos;
    double lat1 = locationObj1.latitude,
      lon1 = locationObj1.longitude,
      lat2 = locationObj2.latitude,
      lon2 = locationObj2.longitude;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
}