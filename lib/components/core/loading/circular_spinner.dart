import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/styles/values.dart';

class CircularSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing(height: Values.marginBelowTitle),
        CircularProgressIndicator(),
      ],
    );
  }
}
