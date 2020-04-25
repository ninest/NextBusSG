import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/constants/strings.dart';
import 'package:provider/provider.dart';
import 'package:nextbussg/components/core/bottom_sheet_template.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/providers/favorites.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:styled_widget/styled_widget.dart';

class ConfirmationBottomSheets {
  static confirmAction(BuildContext context, String code, String service) {
    /*
    The action is either double tapping or long pressing on a service tile.
    The user could intent to ADD or REMOVE the servce from favorites depending on whether it's aready there

    1. Check if the service is already in favorites
      - if yes, show confirmation to REMOVE from favorites
      - if no, show confirmation to ADD to favorites
    2. Proceed with the action using FavoritesProvider
    */

    bool isAlreadyFavorite = FavoritesProvider.alreadyInFavorites(code, service);

    if (isAlreadyFavorite) {
      print("Already in favorites, show confirmation to remove");
      removeFromFavorites(context, code, service);
    } else {
      print("Adding to favorites, show confirmation");
      addToFavorites(context, code, service);
    }
  }

  // at the moment, these values have been hard-coded
  // I'd like the buttons to take the full half widht
  static final double buttonWidth = 100;
  // the sheet height should be the min possible height for the container inside the bottomsheet
  static final double sheetHeight = 170;

  static template(BuildContext context, String code, String service, String text) {
    final FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);

    bottomSheetTemplate(
      context,
      children: <Widget>[
        MarkdownBody(
          data: text,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.body2,
          ),
        ),
        Spacing(height: 25),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Button(
              text: "No",
              iconData: FontAwesomeIcons.times,
              color: Colors.red,
              onTap: () => closeBottomSheet(context),
            ).alignment(Alignment.center).width(buttonWidth),
            // .width(100),
            Button(
              text: "Yes",
              iconData: FontAwesomeIcons.check,
              color: Colors.indigo,
              onTap: () {
                favoritesProvider.addToFavorite(context, code, service);
                closeBottomSheet(context);
              },
            ).alignment(Alignment.center).width(buttonWidth),
          ],
        )
      ],
    );
  }

  // maybe make one function for the template
  static addToFavorites(BuildContext context, String code, String service) =>
      template(context, code, service, Strings.confirmAddToFavorites(service, code));

  static removeFromFavorites(BuildContext context, String code, String service) =>
      template(context, code, service, Strings.confirmRemoveFromFavorites(service, code));
}
