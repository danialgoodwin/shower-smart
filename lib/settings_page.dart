import 'package:flutter/material.dart';
import 'package:shower_smart/user_settings.dart';

class SettingsPage extends StatefulWidget {
  @override _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _volumePerMinute;
  String _volumeUnits;

  @override
  void initState() {
    super.initState();
    UserSettings _userSettings = UserSettings();
    _userSettings.getVolumePerMinute().then((double volumePerMinute) {
      setState(() {
        _volumePerMinute = volumePerMinute;
      });
    });
    _userSettings.getVolumeUnits().then((String volumeUnits) {
      setState(() {
        _volumeUnits = volumeUnits;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Volume per minute'),
            subtitle: Text('$_volumePerMinute'),
            onTap: _showVolumePerMinuteInputPrompt,
          ),
          ListTile(
            title: const Text('Volume units'),
            subtitle: Text('$_volumeUnits'),
            onTap: _showVolumeUnitsInputPrompt,
          ),
//        ListTile.divideTiles(tiles: ''), // TODO: Use?
//        Divider(), // TODO: Use?
          ListTile(
            title: const Text('About app'),
            onTap: _showAboutApp,
          )
        ],
      ),
    );
  }

  void _showAboutApp() {
    // TODO
  }

  void _showVolumePerMinuteInputPrompt() {
    // TODO
  }

  void _showVolumeUnitsInputPrompt() {
    // TODO
  }

}