import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calCubit = context.read<CalendarCubit>();
    // Do stuff here that will run when tab changes
    if (calCubit.state.status.isInitial) {}
    if (calCubit.state.status.isLoading) {}
    if (calCubit.state.status.isSuccess) {}
    return BlocBuilder<CalendarCubit, CalendarState>(
        //buildWhen: (previous, current) => previous.events != current.events,
        builder: (context, state) {
      return BlocProvider.value(
        value: calCubit,
        child: const CalendarViewContainer(),
      );
    });
  }
}

class CalendarViewContainer extends StatelessWidget {
  const CalendarViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit = context.read<CalendarCubit>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
            onPressed: () async {
              await context
                  .read<CalendarCubit>()
                  .fetchEvents(calendarCubit.state.calendars);

              if (context.mounted) {
                await showDismissableModal(context, const CalendarFilterView());
                await calendarCubit.refreshCalendarUI();
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
              onPressed: () async {
                /*calendarCubit.emit(calendarCubit.state
                    .copyWith(status: CalendarStatus.loading));*/
                showDismissableModal(context, Container());
                await calendarCubit.refreshCalendarUI();
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh, semanticLabel: 'Refresh events'),
              onPressed: () async {
                await calendarCubit.refreshCalendar();
                await calendarCubit.refreshCalendarUI();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, semanticLabel: 'New Event'),
              onPressed: () async {
                if (!context.mounted) {
                  return;
                }
                await showDismissableModal(
                    context, const CalendarNewEventView());
                await calendarCubit.refreshCalendarUI();

                //await calendarCubit.refreshCalendarUI();
              },
            ),
          ],
        ),
        body: const CalendarLayout());
  }
}
/*
Future<dynamic> showPopupModal(BuildContext buildContext, Widget widget) {
  return showCupertinoModalPopup(
    semanticsDismissible: true,
    context: buildContext,
    builder: (BuildContext context) {
      return CupertinoPopupSurface(
        child: Container(
          color: CupertinoColors.lightBackgroundGray,
          alignment: Alignment.topCenter,
          width: double.infinity, //double.infinity,
          height: 700,
          child: widget,
        ),
      );
    },
  );
}*/
