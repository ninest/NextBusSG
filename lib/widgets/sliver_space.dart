
import 'package:flutter/material.dart';


class SliverSpacing extends StatelessWidget {
  final double height;
  SliverSpacing({this.height});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: height),
    );
  }
}
