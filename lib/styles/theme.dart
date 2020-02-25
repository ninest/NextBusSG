import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';

final ThemeData appLightTheme = _buildLightTheme();

TextTheme _buildTextTheme(TextTheme base, Color primaryColor) {
  double em = Values.em;

  return base.copyWith(
    title: base.title.copyWith(
      fontWeight: FontWeight.w900,
      fontSize: 1.8 * em,
      letterSpacing: 0.5,
      color: Colors.black,
    ),

    // bus stop names
    display1: base.display1.copyWith(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: em,
    ),
    // bus stop code
    display2: base.display2.copyWith(
      color: Colors.black54,
      fontSize: 0.8 * em,
      fontWeight: FontWeight.w400,
    ),
    // bus numbers
    display3: base.display2.copyWith(
      color: Colors.black87,
      fontSize: 0.9 * em,
      fontWeight: FontWeight.w700,
    ),
    // time in min
    display4: base.display3.copyWith(
      color: Colors.black87,
      fontSize: 0.9 * em,
      fontWeight: FontWeight.w400,
    ),

    // buttons
    button: base.button.copyWith(
      color: primaryColor,
      fontSize: 0.9 * em,
      fontWeight: FontWeight.w600,
    ),

    // bottom sheet text for confirmations?
    body2: base.body2.copyWith(
      fontSize: em,
      fontWeight: FontWeight.w500,
    ),

    // default font
    body1: base.body1.copyWith(
      fontSize: em,
      fontWeight: FontWeight.w400,
    ),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Colors.indigo;
  const Color secondaryColor = Colors.white;
  const Color scaffoldBackgroundColor = Colors.white;

  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),

    // TODO: set status bar color
    // appBarTheme: AppBarTheme(
    //   color: Colors.red,
    //   brightness: Brightness.light,
    // ),
  );

  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme, primaryColor),
  );
}
