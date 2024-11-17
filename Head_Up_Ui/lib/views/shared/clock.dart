import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockRunner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClockRunnerState();
}

class ClockRunnerState extends State<ClockRunner> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1)),
        builder: (context, snapshot) {
          var now = DateTime.now();
          String formattedTime = DateFormat('HH:mm').format(now);
          return Text(
            formattedTime,
            style: TextStyle(fontSize: 60, color: Colors.white),
          );
        });
  }
}
