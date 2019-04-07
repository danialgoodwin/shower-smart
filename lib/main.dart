import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:shower_smart/settings_page.dart';
import 'package:shower_smart/user_settings.dart';
//import 'package:speech_recognition/speech_recognition.dart';

UserSettings _userSettings = UserSettings();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shower Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shower Smart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<_StartStopButtonState> _startStopButtonStateKey = GlobalKey();
  double _volumePerMinute;
  String _volumeUnits;

  @override
  void initState() {
    super.initState();
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

  void _resetTimer() {
    setState(() {
      _startStopButtonStateKey.currentState.reset();
    });
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SettingsPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () { _navigateToSettings(context); },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StartStopButton(key: _startStopButtonStateKey),
            ),
            RaisedButton(
              child: const Text('Reset'),
              shape: StadiumBorder(),
              onPressed: _resetTimer,
            ),
          ],
        ),
      ),
    );
  }
}

class StartStopButton extends StatefulWidget {
  StartStopButton({Key key}): super(key: key);

  @override
  _StartStopButtonState createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  FlutterTts flutterTts = FlutterTts();
  int _lastAnnouncedMinute = 0;
  Timer _timer;
  Stopwatch _stopwatch = Stopwatch();
  Icon _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);
  String _timeText = '00:00';
  String _waterUsageText = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTimeShown());
    _userSettings.getVolumeUnits().then((String volumeUnits) {
      _waterUsageText = '0 $volumeUnits';
    });
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    _stopwatch.start();
    setState(() {
      _icon = Icon(Icons.pause, color: Colors.blue, size: 200);
    });
  }

  void _stop() {
    _stopwatch.stop();
    setState(() {
      _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);
    });
  }

  void reset() {
    _stopwatch.reset();
    _stop();
    _lastAnnouncedMinute = 0;
  }

  void _toggleStartStop() {
    _stopwatch.isRunning ? _stop() : _start();
  }

  Future _speak(String message) async {
    if (message.isEmpty) { return; }
    var result = await flutterTts.speak(message);
//    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  void _updateTimeShown() async {
    var currentMinutes = _stopwatch.elapsed.inMinutes;
    var currentSeconds = _stopwatch.elapsed.inSeconds % 60;

    double volumePerMinute = await _userSettings.getVolumePerMinute();
    String volumeUnits = await _userSettings.getVolumeUnits();

    var waterUsed = volumePerMinute * _stopwatch.elapsed.inSeconds ~/ 6 / 10;
    if (_lastAnnouncedMinute != currentMinutes) {
      _lastAnnouncedMinute = currentMinutes;
      String waterUsedText = '';
      if (volumePerMinute != 0) {
        waterUsedText = 'You\'ve used ${waterUsed.toInt()} $volumeUnits of water';
      }
      if (currentSeconds == 0) {
        _speak('It\'s been $currentMinutes minutes. $waterUsedText');
      } else {
        _speak('It\'s been $currentMinutes minutes and $currentSeconds seconds. $waterUsedText');
      }
    }
    setState(() {
      _timeText = '${currentMinutes.toString().padLeft(2, "0")}:${currentSeconds.toString().padLeft(2, "0")}';
      _waterUsageText = '$waterUsed $volumeUnits';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          child: _icon,
          shape: CircleBorder(),
          onPressed: _toggleStartStop,
        ),
        Text(_timeText),
        Text(_waterUsageText)
      ],
    );



  }

}