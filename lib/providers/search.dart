import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/models/bus_stop.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/services/bus.dart';
import 'package:nextbussg/utils/strings.dart';

class SearchProvider extends ChangeNotifier {
  List _searchResults = [];
  List getSearchResults() => _searchResults;

  bool _noStopsFound = false;
  bool getNoStopsFoundValue() => _noStopsFound;

  getNearestBusStopSearchResults() async {
    // bool canGetPermission = await LocationPermissionsProvider().getBoolPermissionStatus;
    // TODO: fix
    bool canGetPermission = false;
    if (canGetPermission) {
      _searchResults = await BusService.getNearestStops();
      notifyListeners();
    } else {
      BotToast.showText(text: Strings.cannotShowNearByStops, contentColor: Colors.red);
    }
  }

  searchFor(String query) async {
    print("Query rec: $query");

    List allBusStops = await BusService.getAllStops();
    List<BusStop> searchResults = [];

    // make sure query is not empty
    if (query.isNotEmpty) {
      for (BusStop bs in allBusStops) {
        if (bs.name.toLowerCase().contains(query) || bs.code.contains(query)) {
          searchResults.add(bs);
        }
      }
      if (searchResults.isNotEmpty) {
        try {
          _searchResults = searchResults.sublist(0, 50); // for better performance
        } catch (e) {
          _searchResults = searchResults;
        }
        _noStopsFound = false;
        notifyListeners();
      } else {
        // no results for query
        BotToast.showText(text: "No results found.", contentColor: Colors.red);
      }
    } else {
      // if empty, just display stops nearby
      print('getting nearest stops');
      _searchResults = await BusService.getNearestStops();
      notifyListeners();
    }
  }
}
