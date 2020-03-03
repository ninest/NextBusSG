import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Icon(FontAwesomeIcons.chevronLeft),
          // Text("Back", style: Theme.of(context).textTheme.body1,),
        ],
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }
  
}
