import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarLayout extends StatelessWidget {
  const CalendarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<CalendarCubit, CalendarState>(
        buildWhen: (previous, current) =>
            (previous.events != current.events) ||
            (previous.status != current.status),
        builder: (context, state) {
          switch (state.status) {
            case CalendarStatus.initial:
              return const CalendarEmpty();
            case CalendarStatus.loading:
              return const CalendarLoading();
            case CalendarStatus.success:
              return Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 60,
                      child: CalendarMonthWidget(events: state.events)),
                  const Expanded(flex: 40, child: CalendarSchedule()),
                ],
              );
            case CalendarStatus.failure:
              return const CalendarError();
          }
        },
      ),
    );
  }
}
