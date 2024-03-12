import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit = context.read<CalendarCubit>();
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return SfCalendar(
          view: CalendarView.schedule,
          headerHeight: 0,
          scheduleViewSettings: const ScheduleViewSettings(
              hideEmptyScheduleWeek: true,
              monthHeaderSettings: MonthHeaderSettings(height: 70),
              weekHeaderSettings: WeekHeaderSettings(height: 10)),
          dataSource: CalendarEventDataSource(calendarCubit.state.events),
          onTap: (calendarTapDetails) {
            CalendarEvent meeting = calendarTapDetails.appointments?.first;
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
      },
    );
  }
}
