import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nextbussg/components/buttons/button.dart';
import 'package:nextbussg/extensions.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nextbussg/services/renameFavorites.dart';
import 'package:nextbussg/widgets/bottom_sheet_template.dart';
import 'package:nextbussg/widgets/space.dart';

class RenameFavoritesBottomSheets {
  static bs(context, code, name) {
    String currentName = RenameFavoritesService.getName(code);
    print("CURRENT NAME: $currentName");
    // if there area already is a current name, keep that here
    TextEditingController controller = TextEditingController(text: currentName == null ? "" : currentName);
    return bottomSheetTemplate(
      context,
      210,
      [
        MarkdownBody(data: "You are renaming **$name** ($code). Enter your custom name: (leave blank to *reset* rename)")
            .sliverToBoxAdapter(),
        TextField(
          decoration: InputDecoration(
            hintText: name,
          ),
          controller: controller,
        ).sliverToBoxAdapter(),
        Spacing(height: 15).sliver(),
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
                closeBottomSheet(context);
              },
            ),
          ],
        ).sliverToBoxAdapter()
      ],
    );
  }
}
