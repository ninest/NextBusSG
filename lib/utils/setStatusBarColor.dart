import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/utils/theme_enum.dart';

void setStatusBarColor(BuildContext context) {
  final theme = ThemeService.getTheme(context);
  if (Platform.isAndroid) {
    if (theme == ThemeEnum.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.5),
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent.withOpacity(0.5),
        statusBarIconBrightness: Brightness.light,
      ));
    }
  } else if (Platform.isIOS) {
    if (theme == ThemeEnum.light) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.white.withOpacity(0.5));
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    } else {
      FlutterStatusbarcolor.setStatusBarColor(Color(0xcc111111));
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
  }
}
