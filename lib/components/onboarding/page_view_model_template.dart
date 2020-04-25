import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nextbussg/components/onboarding/text_styles.dart';
import 'package:nextbussg/styles/values.dart';

PageViewModel pageViewModelTemplate(
  BuildContext context,
  String title,
  String bodyText,
  Color endColor, {
  String imageUrl,
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
      titleTextStyle: titleTextStyle(context, dark),
      bodyTextStyle: bodyTextStlye(context, dark),
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
            child: Image.asset(imageUrl),
          ),
        ) ??
        null,
    footer: footer,
  );
}
