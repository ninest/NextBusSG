import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/utils/strings.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showBackButton: true,
      children: [
        TitleText(
          title: "Frequently asked questions",
        ).sliverToBoxAdapter(),
        Spacing(
          height: 15,
        ).sliverToBoxAdapter(),
        MarkdownBody(
          data: Strings.faqText,
          styleSheet: MarkdownStyleSheet(
            h1: Theme.of(context).textTheme.display1.copyWith(fontSize: Values.em *1.5),
            p: Theme.of(context).textTheme.body1,
          ),
        ).sliverToBoxAdapter()
      ],
    ).scaffold();
  }
}
