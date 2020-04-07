import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/bounce_scroll.dart';
import 'package:page_transition/page_transition.dart';

class Routing {
  static void openRoute(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScrollConfiguration(
                child: page,
                behavior: BounceScrollBehavior(),
              )),
    );
  }

  // no back allowed
  static void openReplacementRoute(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => ScrollConfiguration(
                child: page,
                behavior: BounceScrollBehavior(),
              )),
    );
  }

  static void closeRoute(BuildContext context) => Navigator.of(context).pop();
}
