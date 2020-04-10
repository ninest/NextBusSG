import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';

class FindingLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Values.pageHorizontalPadding,
        ),
        child: Text(
          "Finding location ...",
          style: Theme.of(context).textTheme.title.copyWith(
                fontSize: Values.em * 1.5,
              ),
        ),
      ),
    );
  }
}
