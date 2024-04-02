import 'package:flutter/material.dart';

// Project
import 'package:multidisplay/experimental/experimental.dart';

class ExperimentalPage extends StatelessWidget {
  const ExperimentalPage({super.key});
  const ExperimentalPage._();

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const ExperimentalPage._());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        /*if (constraints.maxWidth < 400) {
          return const ExperimentalLayoutMobile();
        }*/
        return const ExperimentalLayoutTablet();
      },
    );
  }
}
