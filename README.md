# Shower Smart

Shower smart. Water-wise.

Save water. Save the world. Free up time for other things.

Every minute, this app will announce how long you've been running the water, and how much water you've used.
Use this as motivation for taking shorter showers and using less water. Create free time for other things.

# Running
There are two branches:
- reduce-code-size: 5120 bytes for the Flutter Create challenge: https://flutter.dev/create
- master: Includes more features than 'reduce-code-size' branch: Settings page, user-configurable settings with SharedPreferences, longer variable names, and more

Note: This app has only been tested on Android, though no platform-specific code is used.


# Features:
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
- 2019-04-07: Fully working app around 15k of Dart code as measured by `find . -name "*.dart" | xargs cat | wc -c`
- 2019-04-07: Needed to reduce Dart code size for Flutter Create competition, so created branch 'reduce-code-size'
  - Removed `const`, `final`, `static`, comments, new lines, named parameters
  - Removed handling of edge cases, cancel button
  - Fewer variables, well-named variables, stand-alone widgets, files
  - Shortened variable names
  - Inlining of methods where it's shorter
  - Use more `var`
  - Renamed 'settings' to 'prefs'
  - Removed 'reset' button, and incorporated into start/stop button
  - Removed settings in SettingsPage
  
        Divider(),
        AboutListTile(
          icon: null,
          aboutBoxChildren: <Widget>[
            Text('Save water. Save the world. Free up time for other things.\n\nEvery minute, this app will announce how long you\'ve been'
                ' running the water, and how much water you\'ve used. Use this as motivation for taking shorter showers and using less water.'),
          ],
        ),
        _websiteListTile('Learn more', 'https://water.usgs.gov/edu/qa-home-percapita.html'),
        _websiteListTile('Learn more', 'https://www.epa.gov/watersense'),
        
        ...
        
        ListTile _websiteListTile(String title, String url) {
          return ListTile(
            title: Text(title),
            subtitle: Text(url),
            onTap: () async {
              if (await canLaunch(url)) {
                await launch(url);
              }
            }
          );
        }
  - Had to entirely remove settings_page.dart and user_settings.dart in order to meet 5k code requirement

# License
MIT
