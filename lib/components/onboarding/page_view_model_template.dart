import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel pageViewModelTemplate(
  BuildContext context,
  String title,
  String bodyText,
  Color endColor, {
  image,
  bool dark=false,
  Widget footer
}) =>
    PageViewModel(
      body: bodyText,
      title: title,
      decoration: PageDecoration(
        titleTextStyle: Theme.of(context).textTheme.title.copyWith(
              color: dark ? Colors.white : Colors.black,
            ),
        bodyTextStyle: Theme.of(context).textTheme.body1.copyWith(
              color: dark ? Colors.white70 : Colors.black,
              fontSize: 20,
            ),
        boxDecoration: BoxDecoration(
          color: endColor,
        ),
        contentPadding: EdgeInsets.only(
          // top: 100,
          left: 18,
          right: 18,
        ),
      ),
      image: SafeArea(
        // minimum: EdgeInsets.only(top: 50),
        child: image ?? null,
      ),
      footer: footer,
    );
