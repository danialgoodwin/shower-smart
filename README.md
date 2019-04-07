# Shower Smart

Shower smart. Water-wise.

Save water. Save the world. Free up time for other things.

Every minute, this app will announce how long you've been running the water, and how much water you've used.
Use this as motivation for taking shorter showers and using less water. 

# Running
This repo has two branches:
- reduce-code-size: Code size capped at 5120 bytes of Dart code for the Flutter Create competition: https://flutter.dev/create
- master: Has more features than 'reduce-code-size', including: Settings page, user-configurable settings with SharedPreferences, longer variable names, links to websites about water sustainability

Note: This app has only been tested on Android, though no platform-specific code is used.

# Features
- [x] Start/stop button
- [x] Announce every minute the elapsed time and water used
- [x] Settings page:
  - [x] Configure volume/minute
  - [x] Configure volume units
- [x] 'Rain' animation
- [x] Tips for saving water:
  - https://water.usgs.gov/edu/qa-home-percapita.html
  - https://www.epa.gov/watersense
- [x] The app silently judges you

TODOv2:
- [ ] Voice-activated stopping
- [ ] History graph
  - [ ] Take off 30 (variable) seconds when pressing stop (gives time to dry hand)
- [ ] Save to cloud (Firebase)

# History
- pre-2018: Idea
- 2019-04-06: First commit
- 2019-04-07: Submit app to Flutter Create competition: https://flutter.dev/create

# License
MIT

