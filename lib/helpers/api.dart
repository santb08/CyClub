import 'dart:convert';

import 'package:cyclub/pojos/route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;


/**
 * This function will make a call to the API route for the routes
 * When it gets the response, if the response has an status code of 200 it'll map the response to a list
 * of routes
 * Otherwise, it'll handle the exception sh
 */
Future<List<Route>> getRoutes() async {
  List<Route> list = List();
  final response = await http.get('https://cyclub-api.herokuapp.com/api/map/routes');

  if (response.statusCode == 200){
      list = (json.decode(response.body) as List)
        .map((data) => new Route.fromJson(data))
        .toList();

      return list;
  } else {
    throw Exception('Failed to load routes');
  }
}
