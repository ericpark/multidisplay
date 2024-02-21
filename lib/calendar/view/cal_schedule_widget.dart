import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/repository/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScheduleWidget extends StatelessWidget {
  const CalendarScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.schedule,
      headerHeight: 0,
      scheduleViewSettings: const ScheduleViewSettings(
          hideEmptyScheduleWeek: true,
          monthHeaderSettings: MonthHeaderSettings(height: 70),
          weekHeaderSettings: WeekHeaderSettings(height: 10)),
      dataSource: MeetingDataSource(_getDataSource()),
      onTap: (calendarTapDetails) {
        Meeting meeting = calendarTapDetails.appointments?.first;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Basic dialog title'),
                content: Text(meeting.eventName),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Disable'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Enable'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
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
