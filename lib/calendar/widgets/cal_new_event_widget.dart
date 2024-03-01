import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarNewEvent extends StatelessWidget {
  const CalendarNewEvent({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit = context.read<CalendarCubit>();

    return BlocBuilder<CalendarCubit, CalendarState>(builder: (context, state) {
      return Center(
          child: Flex(direction: Axis.vertical, children: [
        Expanded(
            flex: 10,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  key: const Key('filterWidget_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                IconButton(
                  key: const Key('filterWidget_save_iconButton'),
                  icon: const Icon(Icons.check, semanticLabel: 'Save'),
                  onPressed: () async {
                    CalendarEvent newEventData =
                        state.events[0].copyWith(eventName: "New Event Name");

                    await calendarCubit.addCalendarEvent(newEventData);
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )),
        Expanded(
          flex: 90,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0),
              child: Form(
                // Implement your form key and validation logic
                child: Column(
                  children: [
                    const Text('New Event'),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Event Name'),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                            child: InkWell(
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2024, 12,
                                        31)); // Call Function that has showDatePicker()
                              },
                              child: IgnorePointer(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      hintText: 'Start Date'),
                                  // validator: validateDob,
                                  onSaved: (val) {},
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'End Date'),
                              // Implement date picker logic
                            ),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      onChanged: (value) {
                        //calendarCubit(value!);
                      },
                      value: 'Calendar 1',
                      items: const [
                        DropdownMenuItem(
                          value: 'Calendar 1',
                          child: Text('Calendar 1'),
                        ),
                        DropdownMenuItem(
                          value: 'Calendar 2',
                          child: Text('Calendar 2'),
                        ),
                        DropdownMenuItem(
                          value: 'New',
                          child: Text('New Calendar'),
                        ),
                        // Add more calendars as needed
                      ],
                      decoration:
                          const InputDecoration(labelText: 'Select Calendar'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    /*
                    Container(child: () {
                      if (false) {
                        return const Text('tis true');
                      }
                      return TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'New Calendar Name'),
                      );
                    }()),*/
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]));
    });
  }
}
