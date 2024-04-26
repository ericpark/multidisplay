import 'package:flutter/material.dart';
import 'package:multidisplay/home/home.dart';

class HomeLayoutMobile extends StatelessWidget {
  const HomeLayoutMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Expanded(flex: 20, child: WeatherWidget()),
          Expanded(
              flex: 60,
              child: Container(
                  color: Colors.white, child: const CalendarWidget())),
        ],
      ),
    );
  }
}
