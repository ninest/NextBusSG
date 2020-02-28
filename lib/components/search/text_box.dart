import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:nextbussg/styles/text_fields.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/services/provider/search.dart';
import 'package:nextbussg/styles/values.dart';

// TODO: change to styled_widget
// Still using Division because styled_widget text editable isn't there yet

class SearchTextBox extends StatefulWidget {
  @override
  _SearchTextBoxState createState() => _SearchTextBoxState();
}

class _SearchTextBoxState extends State<SearchTextBox> {
  bool _editing = false;
  // bool _searchText

  @override
  Widget build(BuildContext context) {
    /*
    (1) Change minor styling when search box focussed
    (2) When focussed, add buttons to
      - clear text
      - switch to number keyboard
     */

    final SearchProvider searchProvider = Provider.of<SearchProvider>(context, listen: false);

    TxtStyle style = TxtStyle()
      ..editable(
          enable: true,
          placeholder: "Type a bus or bus stop",
          onFocusChange: (bool value) {
            print('changed, $value');
            setState(() {
              _editing = value;
            });
          },
          onChange: (String searchText) {
            searchProvider.searchFor(searchText);
          })
      ..margin(top: Values.marginBelowTitle)
      ..textColor(TextFieldStyles.textColor(context))
      ..textAlign.left()
      ..fontSize(Values.em)
      ..bold()
      ..padding(all: 15)
      ..borderRadius(all: Values.borderRadius)
      ..alignment.center()
      ..background.color(TextFieldStyles.backgroundColor(context))
      ..border(
        all: _editing ? 4 : 0,
        style: _editing ? BorderStyle.solid : BorderStyle.none,
        color: _editing ? TextFieldStyles.onFocusedBorderColor(context) : Colors.black54,
      );

    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Txt('', style: style),
        ),
        // TODO: add number keyboard and cross button
      ],
    );
  }
}
