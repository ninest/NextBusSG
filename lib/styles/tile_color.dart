import 'package:flutter/material.dart';

class TileColors {
  static Color busStopExpansionTile(context) => Theme.of(context).brightness == Brightness.light
      ? Colors.transparent.withOpacity(0.03)
      : Color(0xff0b0b0b);

  static Color busServiceTile(context) => Theme.of(context).brightness == Brightness.light
      ? Colors.transparent.withOpacity(0.025)
      : Colors.black;
}
