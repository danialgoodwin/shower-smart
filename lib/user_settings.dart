import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {

  final double _defaultVolumePerMinute = 2.5;
  final String _defaultVolumeUnits = 'gallons';

  final String _keyVolumePerMinute = 'keyVolumePerMinute';
  final String _keyVolumeUnits = 'keyVolumeUnits';

  /// Source: https://green.harvard.edu/tools-resources/green-tip/5-ways-measure-5-minute-shower
  /// Source: https://www.epa.gov/watersense/showerheads
  Future<double> getVolumePerMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyVolumePerMinute) ?? _defaultVolumePerMinute;
  }

  Future<double> setVolumePerMinute(double volumePerMinute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyVolumePerMinute, volumePerMinute);
    return volumePerMinute;
  }

  Future<String> getVolumeUnits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyVolumeUnits) ?? _defaultVolumeUnits;
  }

  /// Set the name of the volume units. If input is empty, then set to default value.
  Future<String> setVolumeUnits(String volumeUnits) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String newVolumeUnits = volumeUnits.isEmpty ? _defaultVolumeUnits : volumeUnits;
    await prefs.setString(_keyVolumeUnits, newVolumeUnits);
    return newVolumeUnits;
  }

}