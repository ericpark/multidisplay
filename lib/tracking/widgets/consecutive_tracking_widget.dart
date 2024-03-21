import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

class ConsecutiveTrackingWidget extends StatelessWidget {
  const ConsecutiveTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    required this.lastDate,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""};

  final int id;
  final String section;
  final String trackingName;
  final DateTime lastDate;
  final Map<String, String> mainMetric;
  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;

  @override
  Widget build(BuildContext context) {
    Color? color;
    int hoursSinceLastRecord = DateTime.now().difference(lastDate).inHours;
    int hoursRemainingToday = 24 - DateTime.now().hour;

    if (hoursSinceLastRecord < 24) {
      color = Colors.green[700];
    } else if (hoursSinceLastRecord < 48 && hoursRemainingToday > 0) {
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
