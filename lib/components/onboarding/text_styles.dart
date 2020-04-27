import 'package:flutter/material.dart';

TextStyle bodyTextStlye(BuildContext context, bool dark) =>
    Theme.of(context).textTheme.body1.copyWith(
          color: dark ? Color(0xffaaaaaa) : Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        );

TextStyle titleTextStyle(BuildContext context, bool dark) =>
    Theme.of(context).textTheme.title.copyWith(
          color: dark ? Colors.white : Colors.black,
        );

TextStyle buttonTextStyle(context) => Theme.of(context).textTheme.body1.copyWith(
      color: Colors.black87,
      fontWeight: FontWeight.w700,
    );
TextStyle doneButtonTextStyle(context) => Theme.of(context).textTheme.body1.copyWith(
      color: Colors.white70,
      fontWeight: FontWeight.w700,
    );
