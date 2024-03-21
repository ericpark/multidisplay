import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      listener: (context, state) {},
      builder: (context, state) {
        CalendarCubit calendarCubit = context.read<CalendarCubit>();

        switch (state.status) {
          case CalendarStatus.initial:
            return const CalendarEmpty();
          case CalendarStatus.loading || CalendarStatus.transitioning:
            return const CalendarLoading();
          case CalendarStatus.success:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PhysicalModel(
                color: Theme.of(context).dialogBackgroundColor,
                elevation: 10,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: SfCalendar(
                  view: CalendarView.schedule,
                  headerHeight: 0,
                  scheduleViewSettings: const ScheduleViewSettings(
                      hideEmptyScheduleWeek: true,
                      monthHeaderSettings: MonthHeaderSettings(height: 70),
                      weekHeaderSettings: WeekHeaderSettings(height: 10)),
                  dataSource:
                      CalendarEventDataSource(calendarCubit.state.events),
                  initialSelectedDate: calendarCubit.state.selectedDate,
                  initialDisplayDate: calendarCubit.state.selectedDate,
                  onTap: (calendarTapDetails) async {
                    CalendarEvent event =
                        calendarTapDetails.appointments?.first;
                    Widget container = CalendarEditEventView(event: event);
                    await showDismissableModal(context, container);
                  },
                ),
              ),
            );
          case CalendarStatus.failure:
            return const CalendarError();
        }
      },
    );
  }
}
