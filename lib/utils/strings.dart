class Strings {
  static final String timingsNotAvailableInfo = "Either these buses are not currently in operation, or the API is under maintainance. Please contact the LTA for further information";
  static final String noFavorites = "No favorites near here. **Long press** or **double tap** a bus number to add it to you favorites.";
  static final String renameFavoritesPrompt = "Tap any of the bus stop names below to change their display name:";
  static final String renameFavoritesPrompt2 = "Note that you can rename any favorites. Search for them, then press the **Rename** button.";

  // confirmation bottom sheets
  static String confirmAddToFavorites(service, code) => "Are you sure you want to **_ADD_** Bus **$service** from **$code** to your favorites?";
  static String confirmRemoveFromFavorites(service, code) => "Are you sure you want to **_REMOVE_** Bus **$service** from **$code** from your favorites?";

  // bus stops list
  static final String noStopsNearby = "No bus stops nearby";

  static final String faqText = """
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
}