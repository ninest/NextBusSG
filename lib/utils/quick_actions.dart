import 'package:nextbussg/utils/route.dart';
import 'package:quick_actions/quick_actions.dart';

import 'package:nextbussg/components/home/favorites/all_favorites_page.dart';
import 'package:nextbussg/components/more/mrt_map_page.dart';

setupQA(context, QuickActions quickActions) {
  quickActions.initialize((String shortcutType) {
    switch (shortcutType) {
      case "mrt_map":
        {
          print("MRT MAP");
          Routing.openRoute(context, MRTMapPage());
        }
        break;
      case "favorites":
        {
          Routing.openRoute(context, AllFavoritesPage());
        }
        break;
    }
  });
  quickActions.setShortcutItems(<ShortcutItem>[
    const ShortcutItem(
      type: 'mrt_map',
      localizedTitle: "MRT map",
      icon: 'taskCompleted',
    ),
    const ShortcutItem(
      type: 'favorites',
      localizedTitle: "All Favorites",
      icon: 'love',
    ),
  ]);

  return quickActions;
}
