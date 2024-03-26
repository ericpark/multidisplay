import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/home/home.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer timer;

  var now = DateTime.now();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
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
    final theme = Theme.of(context);

    final homeCubit = context.read<HomeCubit>();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
            color: Theme.of(context).dialogBackgroundColor,
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: Center(
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
                          DateFormat('MMMMEEEEd').format(now),
                          style: theme.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: homeCubit.state.clockType.isMilitary
                          ? Text(
                              DateFormat('Hms').format(now),
                              style: theme.textTheme.displayLarge,
                            )
                          : Text(
                              DateFormat('jms').format(now),
                              style: theme.textTheme.displayLarge,
                            ),
                    )
                  ])
                ],
              ),
            )));
  }
}
