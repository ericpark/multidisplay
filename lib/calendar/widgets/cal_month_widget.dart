import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthWidget extends StatelessWidget {
  const CalendarMonthWidget({super.key});

  void onSelectionChanged(details) {}

  Widget monthCellBuilder(context, details) {
    final isToday = DateTime.now().year == details.date.year &&
        DateTime.now().month == details.date.month &&
        DateTime.now().day == details.date.day;
    final textTheme = Theme.of(context).primaryTextTheme.bodySmall!;
    Color textColor =
        !isToday ? Colors.black : (textTheme.color ?? Colors.white);

    final todayIndicator = isToday
        ? Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, top: 5.0, bottom: 5.0, right: 5.0),
              child: Text(
                details.date.day.toString(),
                style: textTheme.copyWith(color: textColor),
              ),
            ),
          )
        : Container();

    return Stack(
      children: [
        todayIndicator,
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
            child: Text(
              details.date.day.toString(),
              style: textTheme.copyWith(color: textColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget appointmentBuilder(context, CalendarAppointmentDetails eventDetails) {
    final textTheme = Theme.of(context).primaryTextTheme.bodyMedium!;
    final CalendarEvent appointment = eventDetails.appointments.first;
    if (eventDetails.isMoreAppointmentRegion) {
      return SizedBox(
        width: eventDetails.bounds.width,
        height: eventDetails.bounds.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: Text("...",
              textAlign: TextAlign.center,
              style: textTheme.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      );
    }
    return Container(
      width: eventDetails.bounds.width,
      height: eventDetails.bounds.height,
      color: appointment.background,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            appointment.eventName,
            textAlign: TextAlign.left,
            style: textTheme.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        CalendarCubit calendarCubit = context.read<CalendarCubit>();

        switch (state.status) {
          case CalendarStatus.initial:
            return const CalendarEmpty();
          case CalendarStatus.loading:
            return const CalendarLoading();
          case CalendarStatus.success || CalendarStatus.transitioning:
            return SfCalendar(
              view: CalendarView.month,
              viewNavigationMode: ViewNavigationMode.snap,
              monthViewSettings: const MonthViewSettings(
                navigationDirection: MonthNavigationDirection.vertical,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                appointmentDisplayCount: 4,
                dayFormat: 'EEEE',
              ),
              /*monthCellBuilder: (context, details) =>
                  monthCellBuilder(context, details),
              appointmentBuilder: (context, eventDetails) =>
                  appointmentBuilder(context, eventDetails),*/
              dataSource: CalendarEventDataSource(state.events),
              onTap: (CalendarTapDetails calendarTapDetails) async {
                if (calendarTapDetails.targetElement ==
                    CalendarElement.calendarCell) {
                  final selectedDate =
                      calendarTapDetails.date ?? DateTime.now();
                  await calendarCubit.focusOnDate(selectedDate);
                }
              },
              showTodayButton: true,
              showNavigationArrow: true,
              showDatePickerButton: true,
              initialSelectedDate: state.selectedDate,
              initialDisplayDate: state.selectedDate,
            );
          case CalendarStatus.failure:
            return const CalendarError();
        }
      },
    );
  }
}
