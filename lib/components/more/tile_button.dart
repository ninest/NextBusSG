import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';

class TileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  TileButton({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    // if there is no icon, show text only,
    // otherwise show row
    Widget child = Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(
            icon,
            color: Theme.of(context).textTheme.display1.color,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.display1,
          ),
          flex: 5,
        )
      ],
    );

    return InkWell(
      child: Container(
        // these seem to need more padding, not entirely sure why
        padding: EdgeInsets.only(
          top: Values.marginBelowTitle,
          bottom: Values.marginBelowTitle,
        ),
        child: child,
      ),
      enableFeedback: true,
      borderRadius: BorderRadius.circular(Values.borderRadius),
      onTap: () => onTap(),
    );
  }
}
