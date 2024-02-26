import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthWidget extends StatelessWidget {
  const CalendarMonthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
          navigationDirection: MonthNavigationDirection.vertical,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      dataSource: MeetingDataSource(_getDataSource()),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    //final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(2023, 11, 3, 13, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 2));
    meetings.add(Meeting(
        'Ke Mary Otis', startTime, endTime, const Color(0xFF0F8644), false));
    final DateTime startTime2 = DateTime(2024, 2, 13, 13, 0, 0);
    final DateTime endTime2 = startTime2.add(const Duration(days: 10));
    meetings.add(
        Meeting('Milo', startTime2, endTime2, const Color(0xFF0F8644), false));
    return meetings;
  }
}
