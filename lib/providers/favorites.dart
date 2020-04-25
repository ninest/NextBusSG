import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/services/location.dart';
import 'package:nextbussg/constants/distance.dart';
import 'package:provider/provider.dart';


class FavoritesProvider extends ChangeNotifier {
  // the favorites list stores the favorites bus stops and their services
  // in the simplified favorites view, only the bus services of each favorite stop are shown
  // the arrival timings of these buses are shown if the user is near the bus stop

  addToFavorite(context, String code, String service) {
    var box = Hive.box('favorites');

    List prevFavorites = box.get(code, defaultValue: []);

    // first remove if it's already there
    if (alreadyInFavorites(code, service)) {
      print('Removing $code/$service from favorites');
      prevFavorites.remove(service);

      // if the list of services in the code is now empty, delete the key
      if (prevFavorites.isEmpty) {
        box.delete(code);
        notifyListeners();

        // rebuild home
        // Provider.of<HomeRebuilderProvider>(context, listen: false).rebuild();

        // breaking out
        return;

        // if we don't break out, ""box.put(code, prevFavorites);"" will execute
        // and the key will be created again
      }
    } else {
      print("Adding $code/$service to favorites");

      // Add new favorite if not there
      if (!prevFavorites.contains(service)) prevFavorites.add(service);

      // save them back to the box
      // this automatically notifies its listeners
    }
    box.put(code, prevFavorites);

    // print(box.get(code));

    // made sure widgets are rebuilt
    notifyListeners();

    // // rebuild home page
    // Provider.of<HomeRebuilderProvider>(context, listen: false).rebuild();
  }

  static bool alreadyInFavorites(String code, String service) {
    var box = Hive.box('favorites');
    List prevFavorites = box.get(code, defaultValue: []);

    if (prevFavorites.contains(service)) {
      return true;
    } else {
      return false;
    }
  }

  static getFavorites(context, {bool simplified = false}) async {
    var box = Hive.box('favorites');

    List<BusStop> favoritesList = [];

    // get a list of bus stop codes
    var allFavoriteStopCodes = box.keys;
    // print(allFavoriteStopCodes);

    // get their respective data
    Map data = await Provider.of<BusServiceProvider>(context, listen: false).getAllStopsMap();
    for (var stopCode in allFavoriteStopCodes) {
      BusStop busStop = BusStop.fromJson(data[stopCode]);

      if (simplified) {
        // only add to SFV if bus stop near here.
        final LocationServicesProvider locationServicesProvider =
            Provider.of<LocationServicesProvider>(context, listen: false);

        Position currentPosition = await locationServicesProvider.getLocation(context);
        Position busStopPosition = busStop.position;
        double distance =
            await locationServicesProvider.distanceBetween(currentPosition, busStopPosition);

        if (distance < Distance.favoritesNearMe) {
          // we only want to show the bus service (number) which has been favorited
          busStop.services = box.get(stopCode);
          favoritesList.add(busStop);
        }
      } else {
        // if we want all favorites, no filtering happens
        busStop.services = box.get(stopCode);
        favoritesList.add(busStop);
      }
    }
    // print(simplifiedFavorites);
    return favoritesList;
  }

  static getNoFavorites() => Hive.box('favorites').length;
}
