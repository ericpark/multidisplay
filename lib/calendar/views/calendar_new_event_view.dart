import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarNewEventView extends StatelessWidget {
  const CalendarNewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit =
        BlocProvider.of<CalendarCubit>(context, listen: true);

    return BlocProvider(
      create: (formContext) =>
          CalendarFormBloc(calendarList: calendarCubit.state.calendars),
      child: BlocBuilder<CalendarCubit, CalendarState>(
        builder: (calendarContext, calendarState) {
          CalendarFormBloc formBloc = calendarContext.read<CalendarFormBloc>();

          return Center(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 10,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        key: const Key('filterWidget_close_iconButton'),
                        icon: const Icon(Icons.close_outlined,
                            semanticLabel: 'Close'),
                        onPressed: () async {
                          //await calendarCubit.refreshCalendar();
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        key: const Key('filterWidget_save_iconButton'),
                        icon: const Icon(Icons.check, semanticLabel: 'Save'),
                        onPressed: () async {
                          // Perform validation
                          await formBloc.onSubmitting();
                          if (!formBloc.state.isValid()) {
                            return;
                          }

                          // If successful, add event
                          CalendarEvent newEventData =
                              formBloc.toCalendarEvent();
                          await calendarCubit.addCalendarEvent(newEventData);

                          // Dismiss popover
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 90, child: CalendarEventForm())
              ],
            ),
          );
        },
      ),
    );
  }
}
