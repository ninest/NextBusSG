class Strings {
  static String get nearMeTitle => "Near me";
  static String get simplifiedFavoritesTitle => "Favorites";
  static String get allFavoritesTitle => "Favorites";
  static String get searchTitle => "Search";
  static String get moreTitle => "More";

  static String get timingsNotAvailableInfo =>
      "Either these buses are not currently in operation, or the API is under maintainance. Please contact the LTA for further information";
  static String get noFavorites => "**Slide** a bus tile to the left to add it your favorites.";
  static String get renameFavoritesPrompt =>
      "Tap any of the bus stop names below to change their display name:";
  static String get renameFavoritesPrompt2 =>
      "Note that you can rename any favorites. Search for them, then press the **Rename** button.";

  // confirmation bottom sheets
  static String  confirmAddToFavorites(service, code) =>
      "Are you sure you want to **_ADD_** Bus **$service** from stop **$code** to your favorites?";
  static String  confirmRemoveFromFavorites(service, code) =>
      "Are you sure you want to **_REMOVE_** Bus **$service** from stop **$code** from your favorites?";

  // bus stops list
  static String get noStopsNearby =>
      "No bus stops nearby. Are you in Singapore?";
  
  // search
  static String get noStopsFound => "No stops found. Please revise your query.";

  // location permissions
  static String get locationPermissionNotGiven =>
      "Location permissions required to see bus stops nearby.";
  static String get locationPermissionDenied =>
      "Please open the settings to enable location permission.";
  static String get cannotShowNearByStops =>
      "Please enable location permissions to see bus stops near by.";
  static String get afterEnablePermision =>
      'After enabling location permissions in the settings, tap the "Grant location access" button again.';

  static String get faqTitle => "Frequently asked questions";
  static String get faqText => """
# 1. How do I add or remove favorites?
- **Double tap** or **Long press** on any bus service tile, 
- The prompt to add/remove should appear

# 2. Why aren't all my favorites showing?
on the home page, only favorites that are **near** will be shown. To see all your favorites, click on the **"See all"** button.

# 3. How do I rename a bus stop?
There are two ways:
  1. Add the stop to your favorites, then go the "More" page (the third tab on the bottom bar), then tap **"Rename favorites"**
  2. Search for the bus stop in the search page (second tab), and press the **"Rename"** button.

# 4. How do I see more information on a particular bus stop?
There are two ways:
  - Either tap the bus service tile's 5-digit code (ex: 84009), or
  - Search for the bus stop in the search page, tap on the results to see more information
  """;

  static List<String> get messages => [
        // "What do you call a group of pandas? A pandemic.",
        // "How do you react to a lockdown in Singapore? CB!",
        "Hope you're enjoying the app!",
        "Out of the million bus apps, we're glad you chose this one.",
        "This shouldn't take more than 2 seconds ...",
        "Thanks for choosing NextBus SG!",
        "At your service in 2 seconds ...",
      ];
}
