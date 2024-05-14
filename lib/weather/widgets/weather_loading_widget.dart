// Packages
import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';

class WeatherCurrentLoading extends StatelessWidget {
  const WeatherCurrentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = theme.scaffoldBackgroundColor;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Widget placeholder = constraints.maxHeight > 200
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
    },);
  }
}

class WeatherHourlyLoading extends StatelessWidget {
  const WeatherHourlyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadingColor = theme.scaffoldBackgroundColor;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final topPlaceholder = constraints.maxHeight > 200
          ? SizedBox(
              height: constraints.maxHeight * 0.3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 7,
                    child: const WeatherCurrentLoading(),
                  ),
                ],
              ),
            )
          : VerticalCardPlaceholder(
              contentColor: loadingColor,
            );
      final Widget bodyPlaceholder = constraints.maxHeight > 200
          ? ContentPlaceholder(
              lineType: ContentLineType.none,
              height: constraints.maxHeight * 0.6,
              contentColor: loadingColor,
            )
          : VerticalCardPlaceholder(
              contentColor: loadingColor,
            );
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            topPlaceholder,
            bodyPlaceholder,
            /*const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),*/
          ],
        ),
      );
    },);
  }
}
