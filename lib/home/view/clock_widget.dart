import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer timer;

  var now = DateTime.now();
  var nowMinute = "...";
  var nowHour = "...";
  var nowDate = "...";
  var nowDay = "...";
  var nowMonth = "...";
  var nowSeconds = "";

  @override
  void initState() {
    super.initState();

    nowDay = DateFormat('EEEE').format(now);
    nowDate = now.day.toString().padLeft(2, "0");
    nowMonth = now.month.toString().padLeft(2, "0");
    nowMinute = DateTime.now().minute.toString().padLeft(2, "0");
    nowHour = DateTime.now().hour.toString().padLeft(2, "0");
    nowSeconds = DateTime.now().second.toString().padLeft(2, "0");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      setState(() {
        nowDay = DateFormat('EEEE').format(now);
        nowDate = now.day.toString().padLeft(2, "0");
        nowMonth = now.month.toString().padLeft(2, "0");
        nowMinute = DateTime.now().minute.toString().padLeft(2, "0");
        nowHour = DateTime.now().hour.toString().padLeft(2, "0");
        nowSeconds = DateTime.now().second.toString().padLeft(2, "0");
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: [
            const Text("Today is"),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  "$nowDay, $nowMonth/$nowDate",
                  style: const TextStyle(fontSize: 50, color: Colors.black),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.cover,
              child: Text(
                "$nowHour:$nowMinute:$nowSeconds",
                style: const TextStyle(fontSize: 100, color: Colors.black),
              ),
            )
          ])
        ],
      ),
    );
  }
}
