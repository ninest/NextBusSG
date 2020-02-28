import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/widgets/bottom_sheet_template.dart';
import 'package:nextbussg/components/buttons/button.dart';
import 'package:nextbussg/components/buttons/icon_button.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/widgets/space.dart';
import 'package:styled_widget/styled_widget.dart';

class TimingsNotAvailable extends StatelessWidget {
  final List services;
  TimingsNotAvailable({this.services});

  @override
  Widget build(BuildContext context) {
    String displayString = "";
    for (var s in services) {
      displayString += "$s, ";
    }

    // remove the last comma and space because AttEntIon tO deTaIL
    displayString = displayString.substring(0, displayString.length - 2);

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timings unavailable",
                style: Theme.of(context).textTheme.body2,
              ).padding(bottom: 5),
              CustomIconButton(
                icon: FontAwesomeIcons.info,
                size: Theme.of(context).textTheme.body2.fontSize,
                color: Colors.red,
                onTap: () {
                  bottomSheetTemplate(context, 185, [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          MarkdownBody(
                              data:
                                  "Either these buses are not currently in operation, or the API is under maintainance. Please contact the LTA for further information"),
                                  Spacing(height: 20),
                          Button(
                            iconData: FontAwesomeIcons.check,
                            text: "Okay",
                            color: Theme.of(context).primaryColor,
                            onTap: () => closeBottomSheet(context),
                          ).width(120).alignment(Alignment.bottomRight)
                        ],
                      ),
                    ),
                  ]);
                },
              )
            ],
          ),
          Text(displayString).alignment(Alignment.topLeft)
        ],
      ),
    )
        .borderRadius(all: Values.borderRadius * 0.8)
        .padding(all: Values.busServiceTilePadding)
        .border(
          all: 1,
          color: Colors.red,
          style: BorderStyle.solid,
        )
        .borderRadius(all: Values.borderRadius * 0.8)
        .padding(
          bottom: Values.marginBelowTitle,
          horizontal: Values.busServiceTilePadding,
        );
  }
}
