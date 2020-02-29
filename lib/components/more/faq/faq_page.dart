import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/title_text.dart';
import 'package:nextbussg/extensions.dart';
import 'package:nextbussg/strings.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/page_template.dart';
import 'package:nextbussg/widgets/space.dart';

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
