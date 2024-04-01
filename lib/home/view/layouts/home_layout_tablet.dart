import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:multidisplay/home/home.dart';

class HomeLayoutTablet extends StatelessWidget {
  const HomeLayoutTablet({super.key});

  @override
  Widget build(BuildContext context) {
    const cardPadding = EdgeInsets.all(8.0);

    const clockWidget = SimpleCard(
        gradientPreset: GradientPreset.lighten, child: ClockWidget());

    const weatherWidget = SimpleCard(
        gradientPreset: GradientPreset.lighten, child: WeatherWidget());

    const calendarWidget = SimpleCard(
        gradientPreset: GradientPreset.lighten, child: CalendarWidget());

    /// Layout :
    /// |---------------------|
    /// |          |          |
    /// |    50%   |          |
    /// |----------|   100%   |
    /// |          |          |
    /// |    50%   |          |
    /// |---------------------|

    return const SafeArea(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 50,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                      flex: 50,
                      child: Padding(padding: cardPadding, child: clockWidget)),
                  Expanded(
                      flex: 50,
                      child:
                          Padding(padding: cardPadding, child: weatherWidget))
                ],
              )),
          Expanded(
              flex: 50,
              child: Padding(padding: cardPadding, child: calendarWidget)),
        ],
      ),
    );
  }
}
