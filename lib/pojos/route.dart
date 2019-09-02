/**
 * This class will map the objet routes from the DB
 */
class Route {
  final String routeId;
  final String name;
  final String label;
  final List<dynamic> coordinates;

  Route({this.routeId, this.name, this.label, this.coordinates});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      routeId: json['_id'],
      name: json['name'],
      label: json['label'],
      coordinates: json['coordinates']
    );
  }
}