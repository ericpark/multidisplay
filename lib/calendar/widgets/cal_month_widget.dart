import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthWidget extends StatelessWidget {
  const CalendarMonthWidget({super.key, this.events});

  final List<CalendarEvent>? events;

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
        navigationDirection: MonthNavigationDirection.vertical,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      dataSource: CalendarEventDataSource(events ?? []),
    );
  }
}
