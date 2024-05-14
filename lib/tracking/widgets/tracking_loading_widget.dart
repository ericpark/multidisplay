import 'package:custom_components/custom_components.dart'
    show TitlePlaceholder, WidgetPlaceholder;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrackingLoading extends StatelessWidget {
  const TrackingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TitlePlaceholder(
                width: 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Divider(),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: WidgetPlaceholder(),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: WidgetPlaceholder(),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: WidgetPlaceholder(),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: WidgetPlaceholder(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
