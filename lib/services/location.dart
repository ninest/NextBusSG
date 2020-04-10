import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/providers/location_perms.dart';

class LocationServices {
  static Future<Position> getLocation() async {
    try {
      Position position =
          await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      return position;
    } catch (e) {
      // request location
      await LocationPermsProvider.requestPerm();
      return LocationServices.getLocation();
    }
  }

  static Future<double> distanceBetween(Position point1, Position point2) => Geolocator()
      .distanceBetween(point1.latitude, point1.longitude, point2.latitude, point2.longitude);
}
