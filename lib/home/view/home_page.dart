import 'package:flutter/material.dart';
import 'package:multidisplay/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return const Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 50,
                child: Flex(direction: Axis.vertical, children: [
                  Expanded(flex: 50, child: ClockWidget()),
                  Expanded(flex: 50, child: WeatherWidget())
                ])),
            Expanded(flex: 50, child: CalendarWidget()),
          ],
        );
      },
    ));
  }
}
