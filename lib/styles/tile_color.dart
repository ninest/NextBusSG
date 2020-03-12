import 'package:flutter/material.dart';

class TileColors {
  static Color busStopExpansionTile(context) => Theme.of(context).brightness == Brightness.light
      ? Colors.transparent.withOpacity(0.05)
      : Colors.transparent.withOpacity(0.5);

  static Color busServiceTile(context) => Theme.of(context).brightness == Brightness.light
      ? Colors.transparent.withOpacity(0.03)
      : Colors.transparent.withOpacity(0.8);
}
