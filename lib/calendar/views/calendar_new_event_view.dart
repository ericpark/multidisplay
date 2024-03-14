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
      child: Builder(
        builder: (context) {
          CalendarFormBloc formBloc = context.read<CalendarFormBloc>();

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                  key: const Key('newEvent_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () async {
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  }),
              title: const Text("Create New Event"),
              actions: [
                IconButton(
                  key: const Key('newEvent_save_iconButton'),
                  icon: const Icon(Icons.check, semanticLabel: 'Save'),
                  onPressed: () async {
                    // Perform validation
                    await formBloc.onSubmitting();
                    if (!formBloc.state.isValid()) {
                      return;
                    }

                    // If successful, add event
                    CalendarEvent newEventData = formBloc.toCalendarEvent();
                    await calendarCubit.addCalendarEvent(newEventData);

                    // Dismiss popover
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            body: const SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CalendarEventForm()],
              ),
            ),
          );
        },
      ),
    );
  }
}
