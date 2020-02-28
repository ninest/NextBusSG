# Components
- Home (bus related) components
  - `BusStopList`: (2 exist, one for near me, other for favorites) Displays bus stop tiles
  - `BusStopExpansionPanel`: Shows the bus stop name and code. Displays a list of bus service tiles when expanded.
  - `BusServiceTile`: Shows the bus service number and the arrival timings (along with more information)
  - Loading
    - `LoadingBusStopTile`: A placeholder component for `BusStopExpansionPanel`. It takes a parameter `count`, which tells it how many bus stop tiles to build (set to 2).
  - Confirmation
    - `ConfirmationBottomSheets` (not a components, just some bottom sheets) Bottom sheets that confirm the user to add/remove a service to the favorites
- Favorite components
  - `FavoritesBusStopList`: Like `BusStopList`, but with the `simplified` option, which means that it will only show the favorites near the user
  - `AllFavoritesPage`: A whole new page which shows `FavoritesBusStopList`, but with `simplified` set to false (shows ALL favorites)
- Search components
  - `SearchBox`
- Other components
  - `Button`
  - `IconButton`
  - `TitleText`: Used for page titles ("Near me", "favorites", "Search", ...)



## Issues
- I do not know the default vertical and horizontal padding for the `ExpansionPanel` widget, so I had to "eyeball" it to make the placeholder loading widget (`LoadingBusStopTile`). The values provided for padding look fine when the default font size is 19, but may look weird for different sizes.