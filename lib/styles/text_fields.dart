import 'package:flutter/material.dart';

class TextFieldStyles {
  static onFocusedBorderColor(BuildContext context) => Theme.of(context).primaryColor;
  static backgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[200];
  static textColor(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
}