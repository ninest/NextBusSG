import 'package:flutter/material.dart';


class TransitColors {
  // load
  static final Color seats = Colors.green[600];
  static final Color standing = Colors.orange[600];
  static final Color limited = Colors.red;

  static final Map mrtLineColors = {
    'ew': Colors.green,
    'cg': Colors.green,
    'ns': Colors.red,
    'dt': Colors.blue,
    'ne': Colors.purple,
    'ce': Colors.orange,
    'cc': Colors.orange,
    'je': Colors.green[300],
    'te': Colors.brown,

    // smaller lines
    'bp': Colors.grey,

    // Don't know what this is
    'pt': Colors.grey,
    'st': Colors.grey,

  };
}
