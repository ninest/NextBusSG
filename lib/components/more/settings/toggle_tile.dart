import 'package:flutter/material.dart';

class ToggleTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onChange;
  bool isSwitched;
  ToggleTile({this.title, this.icon, this.isSwitched, this.onChange});

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
        Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(widget.icon, color: Theme.of(context).textTheme.display1.color),
        ),
        Expanded(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.display1,
          ),
          flex: 4,
        ),
        Expanded(
          child: Switch(
            value: widget.isSwitched,
            onChanged: (bool value) {
              setState(() {
                widget.isSwitched = value;
              });
              widget.onChange(value);
            },
          ),
          flex: 1,
        ),
      ],
    );
  }
}
