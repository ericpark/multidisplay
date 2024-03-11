import 'package:flutter/cupertino.dart';
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
    return BlocBuilder<CalendarCubit, CalendarState>(builder: (context, state) {
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
    print("REBUILT CAL CONTAINER");
    return BlocConsumer<CalendarCubit, CalendarState>(
        listener: (context, state) {
      if (state.status.isInitial) {}
      if (state.status.isSuccess) {}
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
              onPressed: () async {
                await context
                    .read<CalendarCubit>()
                    .fetchEvents(state.calendars);

                if (context.mounted) {
                  showPopupModal(context, const CalendarFilter());
                }
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
                onPressed: () async {
                  showPopupModal(context, Container());
                },
              ),
              IconButton(
                icon: const Icon(Icons.add, semanticLabel: 'New Event'),
                onPressed: () async {
                  showPopupModal(context, const CalendarNewEventView());
                },
              ),
            ],
          ),
          body: const CalendarLayout());
    });
  }

  void showPopupModal(BuildContext buildContext, Widget widget) {
    showCupertinoModalPopup(
      context: buildContext,
      builder: (BuildContext context) {
        return CupertinoPopupSurface(
          child: Container(
            color: CupertinoColors.white,
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 700,
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                return widget;
              },
            ),
          ),
        );
      },
    );
  }
}
