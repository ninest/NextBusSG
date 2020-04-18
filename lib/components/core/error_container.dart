import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/strings.dart';

class ErrorContainer extends StatelessWidget {
  final String text;
  ErrorContainer({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Values.busServiceTilePadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values.borderRadius * 0.8),
        color: Theme.of(context).errorColor.withOpacity(Values.containerOpacity),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).errorColor,
            ),
      ),
    );
  }
}
