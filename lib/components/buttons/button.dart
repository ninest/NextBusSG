import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:styled_widget/styled_widget.dart';

class Button extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final Function onTap;
  Button({this.iconData, this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (!(iconData == null)) Icon(iconData, color: color),
          Text(
            text,
            style: Theme.of(context).textTheme.button.copyWith(color: color),
          ),
        ],
      ).padding(
        all: 10,
      ),
    )
        .borderRadius(
          all: Values.borderRadius * 0.5,
        )
        .border(
          all: 1,
          color: color == null ? Theme.of(context).primaryColor : color,
        )
        .gestures(onTap: () {
          onTap();
        });
  }
}
