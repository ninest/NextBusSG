import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routing {
  static void openRoute(BuildContext context, Widget page) {
    Navigator.push(
        context,
        // MaterialPageRoute(builder: (context) => page),
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: page,
        ));
  }

  // no back allowed
  static void openReplacementRoute(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }

  static void closeRoute(BuildContext context) => Navigator.of(context).pop();
}
