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
        Expanded(
          child: Icon(
            icon,
            color: Theme.of(context).textTheme.display1.color,
          ),
          flex: 1,
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

    return Padding(
      // these seem to need more padding, not entirely sure why
      padding: EdgeInsets.only(bottom:Values.marginBelowTitle*1.7),
      child: GestureDetector(
        child: child,
        onTap: () => onTap(),
      ),
    );
  }
}
