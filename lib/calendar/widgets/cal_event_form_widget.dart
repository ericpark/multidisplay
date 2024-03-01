import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarEventForm extends StatefulWidget {
  const CalendarEventForm({super.key});

  //ValueNotifier<CalendarEvent?> newEventNotifier = ValueNotifier(null);

  @override
  State<CalendarEventForm> createState() => _CalendarEventFormState();
}

class _CalendarEventFormState extends State<CalendarEventForm> {
  @override
  Widget build(BuildContext context) {
    CalendarCubit calendarCubit = context.read<CalendarCubit>();

    return BlocBuilder<CalendarCubit, CalendarState>(builder: (context, state) {
      return Material(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 0),
          child: Form(
            // Implement your form key and validation logic
            child: Column(
              children: [
                const Text('New Event'),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Event Name'),
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
                              decoration:
                                  const InputDecoration(hintText: 'Start Date'),
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
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
