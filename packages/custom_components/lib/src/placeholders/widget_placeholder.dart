import 'package:flutter/material.dart';

import 'package:custom_components/src/placeholders/placeholders.dart';

class WidgetPlaceholder extends StatelessWidget {
  const WidgetPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
            color: Colors.white,
            elevation: 0,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(10),
            child: const SizedBox(
                height: 200,
                width: 200,
                child: ContentPlaceholder(
                  lineType: ContentLineType.threeLines,
                ))));
  }
}
