import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/components/core/title_text.dart';
import 'package:nextbussg/utils/extensions.dart';
import 'package:nextbussg/constants/strings.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/components/core/page_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/utils/url.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      showBackButton: true,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleText(title: Strings.faqTitle),
            Spacing(height: Values.marginBelowTitle),
            _externalGuideButton(context),
            Spacing(height: Values.marginBelowTitle),
            MarkdownBody(
              data: Strings.faqText,
              styleSheet: MarkdownStyleSheet(
                h1: Theme.of(context).textTheme.display1.copyWith(fontSize: Values.em * 1.5),
                p: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ).sliverToBoxAdapter(),
      ],
    ).scaffold();
  }

  Widget _externalGuideButton(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width / 2.3,
        child: Button(
          text: "Basic guide",
          iconData: FontAwesomeIcons.externalLinkAlt,
          onTap: () => openUrl("https://nextbus.now.sh/guides/basic"),
        ),
      );
}
