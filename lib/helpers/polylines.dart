import 'package:cyclub/helpers/api.dart';
import 'package:cyclub/pojos/route.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Polyline getPolylineFromRoute(Route route){
  List<LatLng> points = List<LatLng>();
  route.coordinates.forEach(
    (coor) => coor.forEach(
      (coor) => points.add(LatLng(coor[1], coor[0]))
  )); 
  print(points);
  return Polyline(
    polylineId: PolylineId(route.name),
    visible: true,       // 75.54779191160074
    points: points,//[LatLng(6.23116127, -75.59998208), LatLng(6.23182977, -75.57790234)],
    width: 5,
    color: prefix0.Colors.red,
  );
}

/**
 * This function will get the routes and will map them into polylines
 */
Future<Set<Polyline>> getRoutesPolylines() async{
  List<Route> routes = await getRoutes();
  Set<Polyline> lines = {};
  routes.forEach((route) => lines.add(getPolylineFromRoute(route)));
  
  lines.add(Polyline(
    polylineId: PolylineId('Ejemplo'),
    visible: true,
    points: [LatLng(-75.59631819, 6.23283426), LatLng(-75.59543287, 6.23368743), LatLng(-75.59543457, 6.23374074), LatLng(-75.59164104, 6.23744621), LatLng(-75.5907612, 6.23832755), LatLng(-75.59006642, 6.23905895), LatLng(-75.58993296, 6.23919945), LatLng(-75.58991458, 6.2392188), LatLng(-75.58979522, 6.2393444), LatLng(-75.58714251, 6.2419752), LatLng(-75.58603371, 6.24307597)],
    width: 3,
    color: prefix0.Colors.blue,
  ));
  return lines;
}