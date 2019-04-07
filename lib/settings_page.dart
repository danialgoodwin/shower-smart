import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:shower_smart/reuse_widget/input_dialogs.dart';
import 'package:shower_smart/third_party/rain_particle_behavior.dart';
import 'package:shower_smart/user_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin {
  UserSettings _settings = UserSettings();
  double _volumePerMinute;
  String _volumeUnits;

  @override
  void initState() {
    super.initState();
    _settings.getVolumePerMinute().then((double volumePerMinute) {
      setState(() {
        _volumePerMinute = volumePerMinute;
      });
    });
    _settings.getVolumeUnits().then((String volumeUnits) {
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
      body: AnimatedBackground(
        behaviour: RainParticleBehaviour(),
        vsync: this,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Volume per minute'),
              subtitle: Text('$_volumePerMinute'),
              onTap: () {
                _showVolumePerMinuteInputPrompt(context);
              },
            ),
            ListTile(
              title: const Text('Volume units'),
              subtitle: Text('$_volumeUnits'),
              onTap: () {
                _showVolumeUnitsInputPrompt(context);
              },
            ),
            Divider(),
            const AboutListTile(
              icon: null,
              aboutBoxChildren: <Widget>[
                Text('Save water. Save the world. Free up time for other things.'
                    '\n\nEvery minute, this app will announce how long you\'ve been'
                    ' running the water, and how much water you\'ve used. Use this'
                    ' as motivation for taking shorter showers and using less water.'),
              ],
//            title: const Text('About app'),
//            onTap: _showAboutApp,
            )
          ],
        ),
      ),
    );
  }

  void _showVolumePerMinuteInputPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialogs.newTextInputDialog(
          context: context,
          title: 'Volume per minute',
          initialValue: _volumePerMinute.toString(),
          hint: 'Ex: 2.5',
          onSubmitted: (String text) async {
            bool isValid = double.tryParse(text) != null;
            if (isValid) {
              double newVpm = await _settings.setVolumePerMinute(double.tryParse(text));
              setState(() {
                _volumePerMinute = newVpm;
              });
            }
          });
      });
  }

  void _showVolumeUnitsInputPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputDialogs.newTextInputDialog(
          context: context,
          title: 'Volume units',
          initialValue: _volumeUnits,
          hint: 'Ex: gallons, liters',
          onSubmitted: (String text) async {
            String newVolumeUnits = await _settings.setVolumeUnits(text);
            setState(() {
              _volumeUnits = newVolumeUnits;
            });
          });
      });
  }
}
