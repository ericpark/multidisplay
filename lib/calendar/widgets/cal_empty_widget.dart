import 'package:flutter/material.dart';

class CalendarEmpty extends StatelessWidget {
  const CalendarEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'No Calendar',
          style: theme.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
