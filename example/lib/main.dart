import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibrate/vibrate.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _canVibrate = true;

  final Iterable<Duration> _pauses = const [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  bool _supportsCustomDuration = false;

  Duration _duration = const Duration(milliseconds: 1000);

  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? print("This device can vibrate")
          : print("This device cannot vibrate");
      _supportsCustomDuration = !Platform.isIOS;
      _supportsCustomDuration
          ? print("This device supports custom durations")
          : print("This device doesn't support custom durations");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Haptic Feedback Example')),
        body: new Center(
          child: new Column(children: <Widget>[
            new ListTile(
                title: new Text("Vibrate"),
                leading: new Icon(Icons.vibration, color: Colors.teal),
                onTap: !_canVibrate
                    ? null
                    : () {
                        if (_supportsCustomDuration) {
                          Vibrate.vibrate(duration: _duration);
                        } else {
                          Vibrate.vibrate();
                        }
                      },
                subtitle: _supportsCustomDuration
                    ? new Row(children: <Widget>[
                        new Slider(
                            min: 500.0,
                            max: 5000.0,
                            value: _duration.inMilliseconds.roundToDouble(),
                            onChanged: (double value) {
                              setState(() {
                                _duration =
                                    new Duration(milliseconds: value.round());
                              });
                            }),
                        new Text("${_duration.inMilliseconds} ms"),
                      ])
                    : null),
            new ListTile(
              title: new Text("Vibrate with Pauses"),
              leading: new Icon(Icons.vibration, color: Colors.brown),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.vibrateWithPauses(_pauses);
                    },
            ),
            new Divider(height: 1.0),
            new ListTile(
              title: new Text("Impact"),
              leading: new Icon(Icons.tap_and_play, color: Colors.orange),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.impact);
                    },
            ),
            new ListTile(
              title: new Text("Selection"),
              leading: new Icon(Icons.select_all, color: Colors.blue),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.selection);
                    },
            ),
            new ListTile(
              title: new Text("Success"),
              leading: new Icon(Icons.check, color: Colors.green),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.success);
                    },
            ),
            new ListTile(
              title: new Text("Warning"),
              leading: new Icon(Icons.warning, color: Colors.red),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.warning);
                    },
            ),
            new ListTile(
              title: new Text("Error"),
              leading: new Icon(Icons.error, color: Colors.red),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.error);
                    },
            ),
            new Divider(height: 1.0),
            new ListTile(
              title: new Text("Heavy"),
              leading:
                  new Icon(Icons.notification_important, color: Colors.red),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.heavy);
                    },
            ),
            new ListTile(
              title: new Text("Medium"),
              leading:
                  new Icon(Icons.notification_important, color: Colors.green),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.medium);
                    },
            ),
            new ListTile(
              title: new Text("Light"),
              leading: new Icon(Icons.notification_important,
                  color: Colors.yellow[700]),
              onTap: !_canVibrate
                  ? null
                  : () {
                      Vibrate.feedback(FeedbackType.light);
                    },
            ),
          ]),
        ),
      ),
    );
  }
}
