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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 400) {
                return const CalendarLayoutMobile();
              }
              return const CalendarLayoutTablet();
            },
          ));
    });
  }
}
