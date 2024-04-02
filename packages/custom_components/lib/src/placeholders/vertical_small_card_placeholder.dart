import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalCardPlaceholder extends StatelessWidget {
  const VerticalCardPlaceholder({
    super.key,
    this.contentColor,
  });

  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.40 * 0.66,
                        height: constraints.maxWidth * 0.40 * 0.66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: contentColor ?? Colors.white,
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: constraints.maxWidth / 3,
                        height: 10.0,
                        color: contentColor ?? Colors.white,
                        margin: const EdgeInsets.only(bottom: 8.0),
                      ),
                      Container(
                        width: constraints.maxWidth / 3,
                        height: 10.0,
                        color: contentColor ?? Colors.white,
                      )
                    ],
                  ))
            ],
          );
        },
      ),
    );
  }
}
