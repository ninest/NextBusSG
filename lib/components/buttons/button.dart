import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:styled_widget/styled_widget.dart';

class Button extends StatelessWidget {
  final IconData iconData;
  final String text;
  Color color;
  final bool fill;
  final Function onTap;
  Button({this.iconData, this.text, this.color, this.onTap, this.fill = false});

  @override
  Widget build(BuildContext context) {
    // set default color
    color = color ?? Theme.of(context).primaryColor;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: fill ? color : null,
          borderRadius: BorderRadius.circular(
            Values.borderRadius * 0.5,
          ),
          border: Border.all(width: fill ? 0.0 : 1.0, color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (!(iconData == null))
              Icon(
                  iconData,
                  color: fill ? Colors.white : color,
                ),
            Text(
                text,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.button.copyWith(
                      color: fill ? Colors.white70 : color,
                    ),
              ),
          ],
        ),
      ),
      onTap: () => onTap(),
    );
  }
}
