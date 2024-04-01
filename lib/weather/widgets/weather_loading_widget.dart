import 'package:custom_components/src/placeholders/title_placeholder.dart';
import 'package:flutter/material.dart';

// Packages
// TODO: Use custom components package
import 'package:custom_components/custom_components.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = theme.scaffoldBackgroundColor;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Update Placeholders
          CenterCardPlaceholder(
            contentColor: loadingColor,
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
