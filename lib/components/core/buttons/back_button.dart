import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(FontAwesomeIcons.chevronLeft, size: 30),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
}
