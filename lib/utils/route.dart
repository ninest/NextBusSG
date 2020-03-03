import 'package:flutter/material.dart';

class Routing {
  static void openRoute(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  static void closeRoute(BuildContext context) => Navigator.of(context).pop();
}
