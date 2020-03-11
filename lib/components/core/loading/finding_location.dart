import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/styles/values.dart';

class FindingLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/location-icon.png'),
          height: 250,
        ),
        Spacing(height: 40),
        Center(
            child: Text(
          "Finding location ...",
          style: Theme.of(context).textTheme.title.copyWith(
            fontSize: Values.em * 1.5,
          ),
        )),
      ],
    );
  }
}
