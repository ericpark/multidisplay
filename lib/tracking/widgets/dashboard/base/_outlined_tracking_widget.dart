///////////////////////////////////////////////////////////////////////////////
/// DEPRECATED: DO NOT USE
///////////////////////////////////////////////////////////////////////////////
// ignore_for_file: dangling_library_doc_comments
import 'package:flutter/material.dart';

class OutlinedTrackingWidget extends StatelessWidget {
  const OutlinedTrackingWidget({
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    super.key,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    this.color,
  })  : leftMetric = leftMetric ?? const {'display_name': '', 'value': ''},
        rightMetric = rightMetric ?? const {'display_name': '', 'value': ''};

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;
  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final widgetColor = color ?? Theme.of(context).colorScheme.primary;

    final centerStyle = Theme.of(context)
        .primaryTextTheme
        .displayLarge!
        .copyWith(color: widgetColor);
    final primaryTextStyle = Theme.of(context)
        .primaryTextTheme
        .headlineSmall!
        .copyWith(color: Colors.black);
    final secondaryTextStyle = Theme.of(context)
        .primaryTextTheme
        .labelLarge!
        .copyWith(fontWeight: FontWeight.bold, color: widgetColor);
    final tertiaryStyle = Theme.of(context)
        .primaryTextTheme
        .labelSmall!
        .copyWith(color: Colors.black);

    // Set Metrics
    final mainMetricName = mainMetric['display_name'] ?? 'Not Found';
    final mainValue = mainMetric['value'] ?? '-';

    final leftMetricName = leftMetric['display_name'] ?? '';
    final leftValue = leftMetric['value'] ?? '-';

    final rightMetricName = rightMetric['display_name'] ?? '';
    final rightValue = rightMetric['value'] ?? '-';

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shadowColor: widgetColor,
        child: SizedBox(
          height: 200,
          width: 200,
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    trackingName,
                    style: primaryTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(mainValue, style: centerStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(mainMetricName, style: tertiaryStyle),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 5,
                    left: 5,
                    right: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Metric
                      Column(
                        children: [
                          Text(leftValue, style: secondaryTextStyle),
                          const SizedBox(height: 5),
                          Text(leftMetricName, style: tertiaryStyle),
                        ],
                      ),
                      // Right Metric
                      Column(
                        children: [
                          Text(rightValue, style: secondaryTextStyle),
                          const SizedBox(height: 5),
                          Text(rightMetricName, style: tertiaryStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
