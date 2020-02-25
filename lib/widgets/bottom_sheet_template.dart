import 'package:flutter/material.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:nextbussg/widgets/page_template.dart';

bottomSheetTemplate(BuildContext context, double height, List children) =>
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          /*
          this high height so that there is an invisble box covering the entire screen
          this way, users cannot interact with anything else until the bottomsheet is gone
          
          done this because if:
            1. user expands the tile
            2. tries to add sth to favorites, but doesn't confirm yet
            3. closes the expanded tile (unexpands it)
          then tries to press a button on the bottom sheet, it causes an error
            """Looking up a deactivated widget's ancestor is unsafe."""
          
          this is probably because of the buildContext ...
          */
          height: 100000,
          child: Container(
            height: height,
            child: PageTemplate(
              children: children,
            ),
          )
              .borderRadius(
                all: Values.borderRadius,
              )
              .backgroundColor(Theme.of(context).scaffoldBackgroundColor)
              .boxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.22),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: 0)
              // TODO: better shadows?
              // .boxShadow(
              //     color: Color.fromRGBO(0, 0, 0, 0.08),
              //     offset: Offset(0, 2),
              //     blurRadius: 4,
              //     spreadRadius: 0)
              .alignment(Alignment.bottomCenter)
              .padding(
                all: Values.marginBelowTitle,
              ),
        );
      },
    );

closeBottomSheet(BuildContext context) => Navigator.of(context).pop();
