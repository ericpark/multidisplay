import 'package:flutter/material.dart';
import 'package:multidisplay/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 400) {
          return const HomeLayoutMobile();
        }
        return const HomeLayoutTablet();
      },
    );
  }
}
