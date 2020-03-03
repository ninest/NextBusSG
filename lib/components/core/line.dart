import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      // nice gray/light white color
      color: Theme.of(context).textTheme.display2.color,
      thickness: 3.0,
      // height: 30.0,
    );
  }
}