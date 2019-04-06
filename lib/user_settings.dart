import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {

  final double defaultVolumePerMinute = 2.5;
  final String defaultVolumeUnits = 'gallons';

  final String keyVolumePerMinute = 'keyVolumePerMinute';
  final String keyVolumeUnits = 'keyVolumeUnits';

  /// Source: https://green.harvard.edu/tools-resources/green-tip/5-ways-measure-5-minute-shower
  /// Source: https://www.epa.gov/watersense/showerheads
  Future<double> getVolumePerMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(keyVolumePerMinute) ?? defaultVolumePerMinute;
  }

  void setVolumePerMinute(double volumePerMinute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keyVolumePerMinute, volumePerMinute);
  }

  Future<String> getVolumeUnits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyVolumeUnits) ?? defaultVolumeUnits;
  }

  void setVolumeUnits(String volumeUnits) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyVolumeUnits, volumeUnits);
  }

}