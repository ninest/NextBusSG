import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/providers/location_perms.dart';

class LocationServicesProvider extends ChangeNotifier {
  // converting it to changeNotifier class so location only has to be retreived once
  Position _position = null;

  Future<Position> getLocation() async {
    if (_position != null) {
      print("Location already there so no need to get it again");
      return _position;
    } else {
      print("Getting location for the first time.");
      try {
        _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
        return _position;
      } catch (e) {
        // request location if not given
        await LocationPermsProvider.requestPerm();
        BotToast.showText(
            text: "Please go to settings to enable location access.", contentColor: Colors.red);
        return getLocation();
      }
    }
  }

  Future<double> distanceBetween(Position point1, Position point2) => Geolocator()
      .distanceBetween(point1.latitude, point1.longitude, point2.latitude, point2.longitude);
}
