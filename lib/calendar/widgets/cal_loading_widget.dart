import 'package:flutter/material.dart';

class CalendarLoading extends StatelessWidget {
  const CalendarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_month),
          Text(
            'Loading Calendar',
            style: theme.textTheme.headlineSmall,
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
