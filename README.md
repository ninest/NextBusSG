# 🚍 NextBus SG – Bus arrivals and information
> An app to show everything bus related in Singapore, including arrival times and a directory.

## 🎆 Gallery
- coming soon

## 🚀 Features
- [x] Show the arrival times of buses at stops near the user
  - [x] Show a list of buses not currently in serivce
  - [x] Show if a bus stop is also an MRT station in the search page
  - [ ] Show which all bus stops around the user are also MRT stations (needs help)
  - [ ] Show timings for college buses (NUS, NTU, SUTD, ...), although still need to collect data for these (check out [this](https://github.com/themindstorm/singapore-bus) repository for updates)
- [x] Ability to save buses at a particular stop as a favorite
  - [x] Confirm user's action of adding/removing from favorites using bottom sheets
    - [ ] Display a toast when a favorite has been added/removed to notfy the user of their actions
  - [x] Automatically show the arrival time of favorite buses at stops (if user is at stop)
  - [x] Add ability to view all favorites in a ~~popup~~ page
  - [x] Show message prompting user to add a favorite if there are no favorites
  - [ ] Custom names for favorites
- [ ] Ability to search for bus services, routes, and stops (Search page)
  - [ ] See information for each of the above
- [ ] Onboarding (introduction) pages to show how to use the app
- [ ] Third page (settings/options page, should also show tutorial on how to use the app)
- [ ] Theme customization 
  - [ ] Light/dark theme
  - [ ] Accent color (unplanned)
  - [ ] Change font size (unplanned)

### 🧨 For the future
- [ ] Tell users how to get to the nearest bus stop (not planned)
- [ ] Map view to show the nearest bus stops
- [ ] Graph view for arrival times, rather than just showing numbers (planned, although implementation is difficult)

## 🛠 Data
Check out [themindstorm/singapore-bus](https://github.com/themindstorm/singapore-bus) for a detailed guide on how the data was scraped. The data is copyrighted by LTA.

## 📦 Packages used
- provider
- hive
- hive_flutter
- geolocator
- styled_widget
- division
- flutter_markdown
- flutter_toast

## Other information
- [Data](https://github.com/themindstorm/singapore-bus) collection start date: February 11, 2020
- Project start date: February 13, 2020 

![badge](https://img.shields.io/badge/Made%20With-Flutter-blue?style=for-the-badge)

## (Move this from here later)
### Getting user location
#### iOS

Go to `ios/Runner/Info.plist`, and add 
```
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
``` 

as a child to the `<dict>` tag.

#### Android
Go to `android/app/src/main/AndroidManifest.xml`, then add 
```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

as a child of the `<manifest>` tag.
