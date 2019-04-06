import 'package:flutter/material.dart';

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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<_StartStopButtonState> _startStopButtonStateKey = GlobalKey();
//  Stopwatch _stopwatch = Stopwatch();

  void _resetTimer() {
    setState(() {
      _startStopButtonStateKey.currentState.stop();
//      _stopwatch.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StartStopButton(key: _startStopButtonStateKey),
            MaterialButton(
              child: Text('Reset'),
              shape: StadiumBorder(),
              onPressed: () { _resetTimer(); },
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
  bool _isStarted = false;
  Icon _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);

  void stop() {
    if (_isStarted) _toggleStartStop();
  }

  void _toggleStartStop() {
    setState(() {
      _isStarted = !_isStarted;
      if (_isStarted) {
        _icon = Icon(Icons.pause, color: Colors.blue, size: 200);
      } else {
        _icon = Icon(Icons.play_arrow, color: Colors.blue, size: 200);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: _icon,
      shape: CircleBorder(),
//      tooltip: 'Start stop button',
//      iconSize: 150,
      onPressed: () {
        _toggleStartStop();
      },
    );
  }

}