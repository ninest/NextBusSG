import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  bool _isFrozen = true;
  bool get freeze => _isFrozen;
  set freeze(bool value) {
    _isFrozen = value;
    notifyListeners();
  }
}
