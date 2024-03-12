import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarFilter extends StatelessWidget {
  const CalendarFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.status.isSuccess) {}
        },
        builder: (context, state) {
          return Flex(
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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      IconButton(
                        key: const Key('filterWidget_save_iconButton'),
                        icon: const Icon(Icons.check, semanticLabel: 'Save'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 90,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.events[0].eventName,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                      const CalendarFilterListTile(),
                      const CalendarFilterListTile(),
                      const CalendarFilterListTile(),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text('Add New'),
                      ),
                    ],
                  )),
            ],
          );
        },
      ),
    );
  }
}

class CalendarFilterListTile extends StatefulWidget {
  const CalendarFilterListTile({super.key});

  @override
  State<CalendarFilterListTile> createState() => _CalendarFilterListTileState();
}

class _CalendarFilterListTileState extends State<CalendarFilterListTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: const Text('Calendar Name'),
        subtitle: const Text('Description (Optional)'),
        leading: Checkbox(
          value: isChecked,
          onChanged: (value) => {
            setState(() {
              isChecked = !isChecked;
            })
          },
        ),
        trailing: IconButton(
          key: const Key('filterWidget_close_iconButton'),
          icon: const Icon(Icons.more_horiz_outlined, semanticLabel: 'Options'),
          onPressed: () => {},
        ),
      ),
    );
  }
}
