import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/styles/values.dart';

class TileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  List<Widget> children;
  TileButton({
    this.text,
    this.icon,
    this.onTap,
    this.children,
  });

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
        margin: EdgeInsets.only(
          top: Values.marginBelowTitle / 2,
          bottom: Values.marginBelowTitle / 2,
        ),
        // these seem to need more padding, not entirely sure why
        padding: EdgeInsets.all(Values.marginBelowTitle),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(Values.containerOpacity),
            borderRadius: BorderRadius.circular(Values.borderRadius)),
        child: Column(
          children: <Widget>[
            child,
            if (children != null) ...[
              Spacing(height: 15,),
              ...children,
            ],
          ],
        ),
      ),
      enableFeedback: true,
      borderRadius: BorderRadius.circular(Values.borderRadius),
      onTap: () => onTap(),
    );
  }
}
