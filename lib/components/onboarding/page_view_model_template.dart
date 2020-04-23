import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nextbussg/styles/values.dart';

TextStyle bodyTextStlye(BuildContext context, bool dark) =>
    Theme.of(context).textTheme.body1.copyWith(
          color: dark ? Color(0xffaaaaaa) : Colors.black,
          fontWeight: FontWeight.w400,
        );

PageViewModel pageViewModelTemplate(
  BuildContext context,
  String title,
  String bodyText,
  Color endColor, {
  image,
  bool dark = false,
  Widget footer,
}) {
  return PageViewModel(
    bodyWidget: MarkdownBody(
      data: bodyText,
      styleSheet: MarkdownStyleSheet(
        p: bodyTextStlye(context, dark),
      ),
    ),
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
      child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Values.marginBelowTitle,
            ),
            child: image,
          ) ??
          null,
    ),
    footer: footer,
  );
}
