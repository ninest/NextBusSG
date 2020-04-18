import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/styles/values.dart';

class AppBackButton extends StatelessWidget {
  // true if the page is a cupertino full screen dialog (mrt page)
  // so the chvron points downwards, and text is "done" instead of "back"
  final bool fullScreen;
  AppBackButton({this.fullScreen = false});

  @override
  Widget build(BuildContext context) {
    final IconData icon = fullScreen ? FontAwesomeIcons.chevronDown : FontAwesomeIcons.chevronLeft;
    final String text = fullScreen ? "done" : "back";

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
              color: Colors.grey.withOpacity(Values.containerOpacity - 0.05),
              borderRadius: BorderRadius.circular(1000.0)),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 10.0), child: Icon(icon, size: 15)),
              Text(
                text,
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
