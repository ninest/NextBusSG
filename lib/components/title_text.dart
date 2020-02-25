import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final IconData iconData;
  TitleText({this.title, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.title),

        // icon does not have to be provided
        Icon(iconData, size: Theme.of(context).textTheme.title.fontSize)
      ],
    );
  }
}
