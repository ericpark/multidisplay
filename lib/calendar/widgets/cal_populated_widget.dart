import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarPopulatedWidget extends StatelessWidget {
  const CalendarPopulatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.status.isSuccess) {}
          if (state.status.isInitial) {}
        },
        builder: (context, state) {
          switch (state.status) {
            case CalendarStatus.initial:
              return const CalendarEmpty();
            case CalendarStatus.loading:
              return const CalendarLoading();
            case CalendarStatus.success:
              return const Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(flex: 60, child: CalendarMonthWidget()),
                  Expanded(flex: 40, child: CalendarScheduleWidget()),
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
