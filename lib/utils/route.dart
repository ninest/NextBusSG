import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/utils/bounce_scroll.dart';

class Routing {
  static void openRoute(BuildContext context, Widget page) {
    print("Maintingn stte");
    Navigator.push(
      context,
      MaterialPageRoute(
        maintainState: true,
        builder: (context) => ScrollConfiguration(
          child: page,
          behavior: BounceScrollBehavior(),
        ),
      ),
    );
  }

  static void openFullScreenDialog(BuildContext context, Widget page) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => ScrollConfiguration(
          child: page,
          behavior: BounceScrollBehavior(),
        ),
      ),
    );
  }

  // no going back allowed
  static void openReplacementRoute(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        maintainState: false,
        builder: (BuildContext context) => ScrollConfiguration(
          child: page,
          behavior: BounceScrollBehavior(),
        ),
      ),
    );
  }

  static void closeRoute(BuildContext context) => Navigator.of(context).pop();
}
