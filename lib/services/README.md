# Services

## Bus
Used to get any bus-related data.

### Functions
- `getNearestStops` -> `List<BusStop>` (uses user location)
- `getAllStops` -> `List<BusStop>`
- `getBusTimings` -> `List<BusArrival>`

## Location
Used to get the user's location, and the distance between two points.

### Functions
- `getLocation` -> `Position`
- `distanceBetween` -> `double`


## Favorites (provider)
Adding to favorites and removing from favorites goes through the same actions: checking if it is in the favorites, then adding or removing it appropriately.

Before anything is added or removed from the favorites, it goes through confirmation. So the `FavoriteProvider` actions are triggered from the confirmation bottom sheets.

### Functions
- `addToFavorite`
- `alreadyInFavorites` -> `bool`
- `getFavorites` -< `List<BusStop>`