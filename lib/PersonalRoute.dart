import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'helpers/distance.dart';

class PersonalRoute {
  DateTime initTime;
  DateTime endTime;
  List<LatLng> coordinates;
  double totalDistance;

  PersonalRoute() {
    initTime = DateTime.now();
  }

  endRoute() {
    print("Route started  at " + initTime.toString());
    endTime = DateTime.now();
    print("Route ended at " + endTime.toString());
    this.getTotalDistance();
  }

  getTotalDistance() {
    var data = this.coordinates;
    double totalDistance = 0;
    for (var i = 0; i < data.length - 1; i++) {
      totalDistance += calculateDistance(data[i], data[i + 1]);
    }
    print("DISTANCIA TOTAL" + totalDistance.toString());
    this.totalDistance = totalDistance;
  }

  setCoordinates(coordinates) {
    // print("EOOOO");
    // print(coordinates);
    this.coordinates = coordinates;
  }

  showJourneyInfo(String distance, double time) {
    //TODO: Alert dialog
  }
}
