import 'package:geolocator/geolocator.dart';

class BusStop {
  final String code;
  final String name;
  final String road;
  final Position position;
  List services; // not final because so it can be edited to show simplified favorites view
  final List mrtStations;

  BusStop({
    this.code,
    this.name,
    this.road,
    this.position,
    this.services,
    this.mrtStations,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return new BusStop(
      code: json['code'],
      name: json['name'],
      road: json['road'],
      position: Position(
        latitude: json['coords']['lat'],
        longitude: json['coords']['lon'],
      ),
      services: json['services'],
      mrtStations: json['mrt_stations'],
    );
  }
}
