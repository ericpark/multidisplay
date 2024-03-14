import 'package:flutter/material.dart';

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
