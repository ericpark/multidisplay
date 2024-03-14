import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarEditEventView extends StatelessWidget {
  const CalendarEditEventView({super.key, required this.event});

  final CalendarEvent event;

  Widget deleteButton(context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(45)),
        child: MaterialButton(
          onPressed: () async {
            final confirmation = await _showWarningDialog(context);
            if (confirmation == true) {
              if (!context.mounted) return;
              Navigator.of(context).pop();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text("Delete"),
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

  Future<bool?> _showWarningDialog(context) async {
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
                  key: const Key('editWidget_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  }),
              title: const Text("Edit Event"),
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
                    CalendarEvent newEventData = formBloc.toCalendarEvent();
                    await calendarCubit.addCalendarEvent(newEventData);

                    // Dismiss popover
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
