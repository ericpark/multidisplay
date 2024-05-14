import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarNewEventView extends StatelessWidget {
  const CalendarNewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarCubit = BlocProvider.of<CalendarCubit>(context);

    return BlocProvider(
      create: (formContext) =>
          CalendarFormBloc(calendarList: calendarCubit.state.calendars),
      child: Builder(
        builder: (context) {
          //CalendarFormBloc formBloc = context.read<CalendarFormBloc>();
          final formBloc = BlocProvider.of<CalendarFormBloc>(context);

          final isKeyboardShowing =
              MediaQuery.of(context).viewInsets.vertical > 0;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                  key: const Key('newEvent_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () async {
                    if (!context.mounted) return;
                    Navigator.pop(
                        context, 'keyboard_showing_$isKeyboardShowing',);
                  },),
              title: const Text('Create New Event'),
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
                    final newEventData = formBloc.toCalendarEvent();
                    await calendarCubit.addCalendarEvent(newEventData);

                    // Dismiss popover
                    if (!context.mounted) return;
                    Navigator.pop(
                        context, 'keyboard_showing_$isKeyboardShowing',);
                  },
                ),
              ],
            ),
            body: const SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
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
