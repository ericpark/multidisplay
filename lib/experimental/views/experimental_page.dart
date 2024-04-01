import 'package:flutter/material.dart';

// Project
import 'package:multidisplay/experimental/experimental.dart';

class ExperimentalPage extends StatelessWidget {
  const ExperimentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        /*if (constraints.maxWidth < 400) {
          return const ExperimentalLayoutMobile();
        }*/
        return const ExperimentalLayoutTablet();
      },
    ));
  }
}
