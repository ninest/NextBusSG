import 'package:flutter/material.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:nextbussg/services/theme.dart';
import 'package:nextbussg/styles/values.dart';
import 'package:nextbussg/utils/theme_enum.dart';

bottomSheetTemplate(
  BuildContext context, {
  bool marginBottom = true,
  List<Widget> children,
}) =>
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 100000,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // flex to push the container to the bottom
              Expanded(flex: 1, child: Container()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Values.pageHorizontalPadding * 0.7),
                padding: EdgeInsets.all(Values.pageHorizontalPadding),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: ThemeService.getTheme(context) == ThemeEnum.dark
                      ? Border.all(
                          color: Colors.black,
                          width: 2,
                        )
                      : null,
                  // increase border radius slightly so it looks better with the rounded buttons
                  borderRadius: BorderRadius.circular(Values.borderRadius * 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.22),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  children: children,
                ),
              ),
              if (marginBottom)
                Spacing(height: 90.0),
            ],
          ),
        );
        /*
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
          // height: 100000,

          // margin to ensure bottom sheet is over tab bar
          margin: EdgeInsets.only(
            bottom: 78.0,
          ),
          child: Container(
              // height: height,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Values.borderRadius),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.22),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                children: children,
              )
              // child: PageTemplate(   children: children,   overscroll: false,),
              ).sliverToBoxAdapter(),
        );
        */
      },
    );

closeBottomSheet(BuildContext context) => Navigator.of(context).pop();

// .borderRadius(
//   all: Values.borderRadius,
// )
// .backgroundColor(Theme.of(context).scaffoldBackgroundColor)
// .boxShadow(
//   color: Color.fromRGBO(0, 0, 0, 0.22),
//   offset: Offset(0, 4),
//   blurRadius: 8,
//   spreadRadius: 2,
// )
// .alignment(Alignment.bottomCenter)
// .padding(
//   all: Values.marginBelowTitle,
// ),
