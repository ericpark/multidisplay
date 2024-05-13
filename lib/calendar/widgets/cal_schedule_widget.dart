import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart' hide CalendarView;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        CalendarCubit calendarCubit = context.read<CalendarCubit>();
        switch (state.status) {
          case CalendarStatus.initial:
            return const CalendarEmpty();
          case CalendarStatus.loading || CalendarStatus.transitioning:
            return const CalendarLoading();
          case CalendarStatus.success:
            return SfCalendar(
              view: CalendarView.schedule,
              headerHeight: 0,
              scheduleViewSettings: ScheduleViewSettings(
                  hideEmptyScheduleWeek: true,
                  monthHeaderSettings: MonthHeaderSettings(
                      height: 70,
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  weekHeaderSettings: const WeekHeaderSettings(height: 10)),
              dataSource: CalendarEventDataSource(calendarCubit.state.events),
              initialSelectedDate: calendarCubit.state.selectedDate,
              initialDisplayDate: calendarCubit.state.selectedDate,
              onTap: (calendarTapDetails) async {
                CalendarEvent event = calendarTapDetails.appointments?.first;
                Widget container = CalendarEditEventView(event: event);
                calendarCubit.startLoading();

                // Changed to navigator for now because two scaffolds cause an issue
                await Navigator.of(context).push(CupertinoModalPopupRoute(
                    barrierDismissible: true,
                    builder: ((context) => container)));
                //await showDismissableModal(context, container);
                calendarCubit.refreshCalendarUI();
              },
            );
          case CalendarStatus.failure:
            return const CalendarError();
        }
      },
    );
  }
}
