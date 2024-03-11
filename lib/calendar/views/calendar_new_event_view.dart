import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarNewEventView extends StatelessWidget {
  const CalendarNewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit =
        BlocProvider.of<CalendarCubit>(context, listen: true);
    print("REBUILT NEWEVENT VIEW CONTAINER");

    return BlocProvider(
        create: (formContext) => CalendarFormBloc(),
        child: BlocBuilder<CalendarCubit, CalendarState>(
            builder: (calendarContext, calendarState) {
          CalendarFormBloc formBloc = calendarContext.read<CalendarFormBloc>();
          return Center(
              child: Flex(direction: Axis.vertical, children: [
            Expanded(
                flex: 10,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      key: const Key('filterWidget_close_iconButton'),
                      icon: const Icon(Icons.close_outlined,
                          semanticLabel: 'Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    IconButton(
                      key: const Key('filterWidget_save_iconButton'),
                      icon: const Icon(Icons.check, semanticLabel: 'Save'),
                      onPressed: () async {
                        CalendarEvent newEventData = calendarState.events[0]
                            .copyWith(eventName: formBloc.name.value);

                        await calendarCubit.addCalendarEvent(newEventData);
                        //await formBloc.onSubmitting();

                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
            Expanded(flex: 90, child: CalendarEventForm())
          ]));
        }));
  }
}
