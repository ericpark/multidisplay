import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScheduleWidget extends StatelessWidget {
  const CalendarScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CalendarCubit calendarCubit = context.read<CalendarCubit>();
        return SfCalendar(
          view: CalendarView.schedule,
          headerHeight: 0,
          scheduleViewSettings: const ScheduleViewSettings(
              hideEmptyScheduleWeek: true,
              monthHeaderSettings: MonthHeaderSettings(height: 70),
              weekHeaderSettings: WeekHeaderSettings(height: 10)),
          dataSource: MeetingDataSource(calendarCubit.getEvents()),
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
      },
    );
  }
}
