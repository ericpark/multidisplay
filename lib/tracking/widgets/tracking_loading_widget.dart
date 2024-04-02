import 'package:flutter/material.dart';
import 'package:custom_components/custom_components.dart'
    show WidgetPlaceholder, TitlePlaceholder;
import 'package:shimmer/shimmer.dart';

class TrackingLoading extends StatelessWidget {
  const TrackingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TitlePlaceholder(
                width: 100,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: WidgetPlaceholder(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: WidgetPlaceholder(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: WidgetPlaceholder(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: WidgetPlaceholder(),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
