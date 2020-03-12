import 'package:flutter/material.dart';

class BorderColors {
  static Color busStopExpansionPanel(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.transparent;
  static Color busServiceTile(BuildContext context) =>  Theme.of(context).brightness == Brightness.dark ? Colors.white38 :  Colors.black38;
  // static Color busServiceTile(BuildContext context) =>  Colors.white;
}