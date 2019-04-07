import 'dart:async';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shower_smart/rain_particle_behavior.dart';

var _title = 'Shower Smart';
var _vpm = 2.5;
var _units = 'gallons';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: AnimatedBackground(behaviour: RainParticleBehaviour(), vsync: this, child: StartStopButton())
    );
  }
}

class StartStopButton extends StatefulWidget {
  @override _StartStopButtonState createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  var _tts = FlutterTts();
  var _ttsMinute = 0;
  var _stopwatch = Stopwatch();
  var _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);
  var _timeText = '00:00', _waterUsageText = '0 $_units';

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTimeShown());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(child: _icon, shape: CircleBorder(),
          onPressed: () { _stopwatch.isRunning ? _stop() : _start(); },
        ),
        Text(_timeText),
        Text(_waterUsageText),
        Text('\n$_vpm $_units/minute')
      ],
    );
  }

  void _start() {
    _stopwatch.start();
    setState(() {
      _icon = Icon(Icons.pause, color: Colors.blue, size: 200);
    });
  }

  void _stop() {
    _stopwatch.stop();
    _stopwatch.reset();
    _ttsMinute = 0;
    setState(() {
      _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);
    });
  }

  void _speak(String message) async => await _tts.speak(message);

  void _updateTimeShown() async {
    var minutes = _stopwatch.elapsed.inMinutes;
    var seconds = _stopwatch.elapsed.inSeconds % 60;
    var waterUsed = _vpm * _stopwatch.elapsed.inSeconds ~/ 6 / 10;
    if (_ttsMinute != minutes) {
      _ttsMinute = minutes;
      _speak('It\'s been $minutes minutes. You\'ve used ${waterUsed.toInt()} $_units of water');
    }
    setState(() {
      _timeText = '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
      _waterUsageText = '$waterUsed $_units';
    });
  }

}