import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeRebuilderProvider extends ChangeNotifier {
  void rebuild() => notifyListeners();

  // to save the location between home page rebuilds
  Position _position;
  set position(Position val) {
    _position = val;
    notifyListeners();
  }
  get position => _position;
}