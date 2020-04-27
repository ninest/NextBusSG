import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/providers/home_rebuilder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/services/rename_favorites.dart';
import 'package:nextbussg/components/core/bottom_sheet_template.dart';
import 'package:nextbussg/components/core/space.dart';
import 'package:provider/provider.dart';

class RenameFavoritesBottomSheets {
  static bs(context, code, name) {
    String currentName = RenameFavoritesService.getName(code);
    // if there area already is a current name, keep that here
    TextEditingController controller =
        TextEditingController(text: currentName == null ? "" : currentName);
    return bottomSheetTemplate(
      context,
      children: <Widget>[
        MarkdownBody(data: "Enter new name for **$name** ($code). Leave the field blank to reset the name.\n\nEnter your custom name: "),
        Spacing(height: 15),
        TextField(
          decoration: InputDecoration(
            hintText: name,
          ),
          controller: controller,
        ),
        Spacing(height: 15),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Button(
              text: "Dismiss",
              iconData: FontAwesomeIcons.times,
              color: Colors.red,
              onTap: () => closeBottomSheet(context),
            ),
            Button(
              text: "Change",
              iconData: FontAwesomeIcons.check,
              onTap: () {
                String newName = controller.text.trim();
                if (newName.isNotEmpty) {
                  print("Chaning name");
                  RenameFavoritesService.rename(context, code, newName);
                } else {
                  print("Empty string provided, reseting rename");
                  RenameFavoritesService.deleteRename(code);
                }

                // rebuild stop overview page to reflect rename
                closeBottomSheet(context);
                Provider.of<HomeRebuilderProvider>(context, listen: false).rebuild();
              },
            ),
          ],
        ),
        
      ],
    );
  }
}
