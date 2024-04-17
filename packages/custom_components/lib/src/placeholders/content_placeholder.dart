import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ContentLineType {
  twoLines,
  threeLines,
  none,
}

class ContentPlaceholder extends StatelessWidget {
  const ContentPlaceholder({
    super.key,
    required this.lineType,
    this.contentColor,
    this.height,
  });

  final ContentLineType lineType;
  final Color? contentColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    if (lineType == ContentLineType.none) {
      return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: height ?? 100.0,
              color: contentColor ?? Colors.white,
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
          ));
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 96.0,
              height: height ?? 72.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: contentColor ?? Colors.white,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  if (lineType == ContentLineType.threeLines)
                    Container(
                      width: double.infinity,
                      height: 10.0,
                      color: contentColor ?? Colors.white,
                      margin: const EdgeInsets.only(bottom: 8.0),
                    ),
                  Container(
                    width: 100.0,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
