import 'package:flutter/material.dart';
import 'package:multidisplay/tracking/tracking.dart';

class FixedWeekTrackingWidget extends StatelessWidget {
  const FixedWeekTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    required this.remaining,
    List<int>? threshold,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""},
        threshold = threshold ?? const [1, 0];

  final int id;
  final String section;
  final String trackingName;
  final int remaining;
  final Map<String, String> mainMetric;
  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final List<int> threshold;

  @override
  Widget build(BuildContext context) {
    Color? color;

    if (remaining >= threshold[0]) {
      color = Colors.green[700];
    } else if (remaining >= threshold[1]) {
      color = Colors.amber[700];
    } else {
      color = Colors.red[700];
    }

    return SimpleTrackingWidget(
      id: id,
      section: section,
      trackingName: trackingName,
      mainMetric: mainMetric,
      leftMetric: leftMetric,
      rightMetric: rightMetric,
      color: color,
    );
  }
}
