import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      // nice gray/light white color
      color: Colors.grey.withOpacity(0.1),
      thickness: 3.0,
      // height: 30.0,
    );
  }
}