import 'package:geolocator/geolocator.dart';

class LocationServices {
  static Future<Position> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  static Future<double> distanceBetween(Position point1, Position point2) =>
      Geolocator().distanceBetween(
        point1.latitude,
        point1.longitude,
        point2.latitude,
        point2.longitude,
      );
  
  
}
