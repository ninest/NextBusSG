import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Function onTap;
  CustomIconButton({this.icon, this.color, this.size, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    ).gestures(onTap: () {
      onTap();
    });
  }
}
