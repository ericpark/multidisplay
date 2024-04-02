import 'package:flutter/material.dart';

// Packages
import 'package:custom_components/custom_components.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = theme.scaffoldBackgroundColor;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Widget placeholder = constraints.maxHeight > 200
          ? CenterCardPlaceholder(
              contentColor: loadingColor,
            )
          : VerticalCardPlaceholder(
              contentColor: loadingColor,
            );
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            placeholder,
            /*const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),*/
          ],
        ),
      );
    });
  }
}
