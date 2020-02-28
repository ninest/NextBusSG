import 'package:flutter/material.dart';

class BorderColors {
  static Color busStopExpansionPanel(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black54;
  static Color busServiceTile(BuildContext context) =>  Theme.of(context).brightness == Brightness.dark ? Colors.white54 :  Colors.black45;
}