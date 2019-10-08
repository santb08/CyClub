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
  return Polyline(
    polylineId: PolylineId(route.name),
    visible: true,
    points: points,
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

  return lines;
}