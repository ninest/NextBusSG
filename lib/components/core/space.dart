import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double height;
  Spacing({this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height.toDouble()),
    );
  }

  Widget sliver() {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: height.toDouble()),
    );
  }

  Widget side() {
    return Padding(
      padding: EdgeInsets.only(left: height.toDouble()),
    );
  }
}
