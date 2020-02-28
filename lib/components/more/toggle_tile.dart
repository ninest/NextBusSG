import 'package:flutter/material.dart';

class ToggleTile extends StatefulWidget {
  final String title;
  final Function onChange;
  bool isSwitched;
  ToggleTile({this.title, this.isSwitched, this.onChange});

  @override
  _ToggleTileState createState() => _ToggleTileState();
}

class _ToggleTileState extends State<ToggleTile> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.title,
          style: Theme.of(context).textTheme.display1,
        ),
        Switch(
          value: widget.isSwitched,
          onChanged: (bool value) {
            setState(() {
              widget.isSwitched = value;
            });
            widget.onChange(value);
          },
        )
      ],
    );
  }
}
