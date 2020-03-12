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
import 'package:nextbussg/utils/distance.dart';

class BusService extends ChangeNotifier {
  // Make this use changeNotifier too?

  static Future<List> getNearestStops() async {
    Position userPosition = await LocationServices.getLocation();
    String jsonString = await rootBundle.loadString('assets/bus_stops.json');
    Map data = json.decode(jsonString);

    List busStopsNear = [];

    for (var stopCode in data.keys) {
      // for (var stopCode in data.keystoList().sublist(0,5)) {
      BusStop busStop = BusStop.fromJson(data[stopCode]);

      // calculating distance (meters) between current position and bus stop coords
      double distance = await LocationServices.distanceBetween(userPosition, busStop.position);

      // add it if bus stop is within 500 meters
      if (distance < Distance.nearMe) {
        // add to bus stops near me list
        busStopsNear.add(busStop);
      }
    }

    return busStopsNear;

    // use this for testing purposes only
    // return [busStopsNear[0]];
  }

  static Future<List> getAllStops() async {
    String jsonString = await rootBundle.loadString('assets/bus_stops.json');
    Map data = json.decode(jsonString);

    List allBusStops = [];

    for (var stopCode in data.keys) {
      BusStop busStop = BusStop.fromJson(data[stopCode]);
      allBusStops.add(busStop);
    }

    return allBusStops;
  }

  static getBusTimings(String stopCode) async {
    print('Getting arrivals for $stopCode');

    var response = await http.get(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=$stopCode',
        headers: {'AccountKey': apiKey, 'accept': 'application/json'});
    if (response.statusCode != 200) {
      BotToast.showText(text: "Error in request: ${response.statusCode}. Please restart app or check your internet connectivity", contentColor: Colors.red);
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
