import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nextbussg/keys.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_arrival.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:nextbussg/constants/distance.dart';
import 'package:provider/provider.dart';

class BusServiceProvider extends ChangeNotifier {
// class BusServiceProvider {
  
  // this is there to save nearby bus stops in the state. That way, we only have to go through all bus stops
  // and find those nearby once
  // This will be reset when the refresh button is pressed
  List<BusStop> _busStopsNear = null;

  // reload is false by default; it's only true when we need to get new set of nearest bus stops
  Future<List> getNearestStops(context, {reload: false}) async {
    if (_busStopsNear != null && !reload) {
      // if busStopsNear is already saved in state, no need to get it again
      return _busStopsNear;
    } else {
      // this function should only execute ONCE to get bus stops near by
      final LocationServicesProvider locationServicesProvider = Provider.of<LocationServicesProvider>(context, listen: false);

      Position userPosition = await locationServicesProvider.getLocation(context);
      Map data = await getAllStopsMap();

      List<BusStop> busStopsNear = [];

      for (var stopCode in data.keys) {
        BusStop busStop = BusStop.fromJson(data[stopCode]);

        // calculating distance (meters) between current position and bus stop coords
        double distance = await locationServicesProvider.distanceBetween(userPosition, busStop.position);

        // add it if bus stop is within 500 meters
        if (distance < Distance.nearMe) {
          // add to bus stops near me list
          busStopsNear.add(busStop);
        }
      }

      _busStopsNear = busStopsNear;
      return _busStopsNear;
    }

    // use this for testing purposes only
    // return [busStopsNear[0]];
  }

  Map _allBusStopsMap = null;
  Future<Map> getAllStopsMap() async {
    if (_allBusStopsMap == null) {
      // Loading bus stops map - this should only come once
      String jsonString = await rootBundle.loadString('assets/bus_stops.json');
      _allBusStopsMap = json.decode(jsonString);
    }
    return _allBusStopsMap;
  }

  getBusTimings(String stopCode) async {
    print('Getting arrivals for $stopCode');

    var response = await http.get(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$stopCode',
        headers: {'AccountKey': apiKey, 'accept': 'application/json'});
    if (response.statusCode != 200) {
      BotToast.showText(
          text:
              "Error in request: ${response.statusCode}. Please restart app or check your internet connectivity",
          contentColor: Colors.red);
      return [];
    }

    Map data = json.decode(response.body);

    List<BusArrival> busArrivalList = [];
    for (var eachService in data['Services']) {
      BusArrival busArrival = BusArrival.fromJson(eachService);

      // remove buses that have already arrived and left
      try {
        if (busArrival.nextBuses[0].timeInMinutes.contains('-')) {
          // removing the negative time,
          busArrival.nextBuses.removeAt(0);
          // and adding a placeholder timing (which is empty)
          busArrival.nextBuses.add(NextBus(timeInMinutes: null, load: null, feature: null));
        }
      } catch (e) {
        print("Error in removing buses ($stopCode, $eachService) that have already left: $e");
      }

      busArrivalList.add(busArrival);
    }

    return busArrivalList;
  }
}
