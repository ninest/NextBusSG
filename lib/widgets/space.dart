
import 'package:flutter/material.dart';


class Spacing extends StatelessWidget {
  final int height;
  Spacing({this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height.toDouble()),
    );
  }
}
