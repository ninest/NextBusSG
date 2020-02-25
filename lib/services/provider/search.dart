import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/services/bus.dart';

class SearchProvider extends ChangeNotifier {
  List _searchResults = [];
  List getSearchResults() {
    return _searchResults;
  } 

  searchFor(String text) async {
    // if the string is empty or null, search results should just display the nearest bus stops (and buses)
    if (text == "" || text == null) {
      print("No query, giving nearest bus stops");
      _searchResults = await BusService.getNearestStops();
    } else {
      List allBusStops = await BusService.getAllStops();
      // TODO: implement search
      for (BusStop bs in allBusStops.sublist(0,15)) {
        // print(bs.code);
      }
    }
    notifyListeners();
  }
}