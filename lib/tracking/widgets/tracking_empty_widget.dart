import 'package:flutter/material.dart';

class TrackingEmpty extends StatelessWidget {
  const TrackingEmpty({super.key});

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
