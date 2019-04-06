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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
            StartStopButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StartStopButton extends StatefulWidget {
  @override
  _StartStopButtonState createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  bool _isStarted = false;
  String _text = "Start";
  Icon _icon = Icon(Icons.play_arrow, color: Colors.blue);

  void _toggleStartStop() {
    setState(() {
      _isStarted = !_isStarted;
      if (_isStarted) {
        _icon = Icon(Icons.pause, color: Colors.blue);
        _text = "Stop";
      } else {
        _icon = Icon(Icons.play_arrow, color: Colors.blue);
        _text = "Start";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _icon,
      tooltip: 'Start stop button',
      iconSize: 150,
      onPressed: () {
        _toggleStartStop();
      },
    );
  }

}