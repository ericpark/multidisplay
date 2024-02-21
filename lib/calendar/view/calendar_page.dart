import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(flex: 60, child: CalendarMonthWidget()),
          Expanded(flex: 40, child: CalendarScheduleWidget()),
        ],
      ),
    );
  }
}
