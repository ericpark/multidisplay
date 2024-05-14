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
  late HomeCubit homeCubit;
  late String timePattern;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });

    homeCubit = context.read<HomeCubit>();
    timePattern = homeCubit.state.clockType.isMilitary ? 'Hms' : 'jms';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final timePattern = homeCubit.state.clockType.isMilitary ? 'Hms' : 'jms';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              const Text('Today is'),
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
                child: Text(
                  DateFormat(timePattern).format(now),
                  style: theme.textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    /* Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
            color: Theme.of(context).dialogBackgroundColor,
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.hardEdge,
            child: ClockContent(now: now, theme: theme, homeCubit: homeCubit)));
    */
  }
}

class ClockContent extends StatelessWidget {
  const ClockContent({
    required this.now,
    required this.theme,
    required this.homeCubit,
    super.key,
  });

  final DateTime now;
  final ThemeData theme;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    final timePattern = homeCubit.state.clockType.isMilitary ? 'Hms' : 'jms';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              const Text('Today is'),
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
                child: Text(
                  DateFormat(timePattern).format(now),
                  style: theme.textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
