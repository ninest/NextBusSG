import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/styles/values.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(1000.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(Values.containerOpacity),
              borderRadius: BorderRadius.circular(1000.0)),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(FontAwesomeIcons.chevronLeft, size: 15)),
              Text(
                "back",
                style: Theme.of(context).textTheme.body1.copyWith(
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
