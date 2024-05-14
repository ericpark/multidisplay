import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarSegmentButton extends StatelessWidget {
  const CalendarSegmentButton({
    required this.selected, required this.onChange, super.key,
  });

  final CalendarView selected;
  final void Function(CalendarView) onChange;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<CalendarView>(
        segments: const <ButtonSegment<CalendarView>>[
          ButtonSegment<CalendarView>(
              value: CalendarView.month,
              label: Text('Month'),
              icon: Icon(Icons.calendar_month),),
          ButtonSegment<CalendarView>(
              value: CalendarView.schedule,
              label: Text('Schedule'),
              icon: Icon(Icons.calendar_view_day),),
        ],
        selected: <CalendarView>{
          selected,
        },
        onSelectionChanged: (Set<CalendarView> newSelection) =>
            onChange(newSelection.first),);
  }
}
