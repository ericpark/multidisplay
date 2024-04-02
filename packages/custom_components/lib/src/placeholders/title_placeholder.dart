import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 12.0,
              color: Colors.white,
            ),
            const SizedBox(height: 8.0),
            Container(
              width: width,
              height: 12.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
