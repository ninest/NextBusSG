import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/styles/values.dart';

class CircularSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing(height: Values.marginBelowTitle),
        Text(
          "Loading ...",
          style: Theme.of(context).textTheme.title.copyWith(
                fontSize: Values.em * 1.5,
              ),
        ),
        Spacing(height: Values.marginBelowTitle),
      ],
    );
  }
}
