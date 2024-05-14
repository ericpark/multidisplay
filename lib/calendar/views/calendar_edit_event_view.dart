import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarEditEventView extends StatelessWidget {
  const CalendarEditEventView({required this.event, super.key});

  final CalendarEvent event;

  Widget deleteButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(45),
        ),
        child: MaterialButton(
          onPressed: () async {
            final confirmation = await _showWarningDialog(context);
            if ((confirmation ?? false) == true) {
              if (!context.mounted) return;
              Navigator.of(context).pop();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text('Delete'),
              ),
              IconButton(
                key: const Key('editWidget_delete_iconButton'),
                icon: const Icon(Icons.delete, semanticLabel: 'Delete'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showWarningDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text('Do you want to delete this event?'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final calendarCubit = BlocProvider.of<CalendarCubit>(context, listen: true);

    return BlocProvider(
      create: (formContext) =>
          CalendarFormBloc(calendarList: calendarCubit.state.calendars),
      child: Builder(
        builder: (context) {
          final formBloc = context.read<CalendarFormBloc>();

          final isKeyboardShowing =
              MediaQuery.of(context).viewInsets.vertical > 0;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                key: const Key('editWidget_close_iconButton'),
                icon: const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                onPressed: () async {
                  Navigator.pop(
                    context,
                    'keyboard_showing_$isKeyboardShowing',
                  );
                },
              ),
              title: const Text('Edit Event'),
              actions: [
                IconButton(
                  key: const Key('editWidget_save_iconButton'),
                  icon: const Icon(Icons.check, semanticLabel: 'Save'),
                  onPressed: () async {
                    // Perform validation
                    await formBloc.onSubmitting();
                    if (!formBloc.state.isValid()) {
                      return;
                    }

                    // If successful, add event
                    final updatedEvent = formBloc.toCalendarEvent();
                    await calendarCubit.updateCalendarEvent(
                      eventId: event.id,
                      event: updatedEvent,
                    );
                    //await calendarCubit.refreshCalendarUI();
                    // Dismiss popover
                    if (!context.mounted) return;
                    Navigator.pop(
                      context,
                      'keyboard_showing_$isKeyboardShowing',
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  CalendarEventForm(event: event),
                  deleteButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
