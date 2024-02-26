import 'package:flutter/material.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/home/widgets/weather_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Flex(
      direction: Axis.vertical,
      children: [
        Expanded(flex: 100, child: ClockWidget()),
        Expanded(
            flex: 0,
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(flex: 20, child: WeatherWidget()),
              Expanded(flex: 80, child: WeatherWidget())
            ])),
      ],
    );
  }
}
