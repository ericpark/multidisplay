import 'package:flutter/material.dart';
import 'package:multidisplay/tracking/tracking.dart';

class OutlinedTrackingWithButtonWidget extends StatelessWidget
    with TrackingDialog {
  const OutlinedTrackingWithButtonWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    this.color,
    this.isActive = false,
    this.onPress,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""};

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;
  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;

  // True = button is showing, false = button is not showing
  final bool isActive;
  final Future<void> Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final widgetColor = color ?? Theme.of(context).colorScheme.primary;

    final TextStyle centerStyle = Theme.of(context)
        .primaryTextTheme
        .displayLarge!
        .copyWith(color: widgetColor);
    final TextStyle primaryTextStyle = Theme.of(context)
        .primaryTextTheme
        .headlineSmall!
        .copyWith(color: Colors.black);
    final TextStyle secondaryTextStyle = Theme.of(context)
        .primaryTextTheme
        .labelLarge!
        .copyWith(fontWeight: FontWeight.bold, color: widgetColor);
    final TextStyle tertiaryStyle = Theme.of(context)
        .primaryTextTheme
        .labelSmall!
        .copyWith(color: Colors.black);

    // Set Metrics
    final String mainMetricName = mainMetric["display_name"] ?? "Not Found";
    final String mainValue = mainMetric["value"] ?? "-";

    final String leftMetricName = leftMetric["display_name"] ?? "";
    final String leftValue = leftMetric["value"] ?? "-";

    final String rightMetricName = rightMetric["display_name"] ?? "";
    final String rightValue = rightMetric["value"] ?? "-";

    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: widgetColor,
      child: SizedBox.expand(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          trackingName,
                          style: primaryTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(mainValue, style: centerStyle),
                        Text(mainMetricName, style: tertiaryStyle),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 2,
                  child: isActive
                      ? Row(
                          crossAxisAlignment: isActive
                              ? CrossAxisAlignment.stretch
                              : CrossAxisAlignment.center,
                          mainAxisAlignment: isActive
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: [
                              FittedBox(
                                fit: BoxFit.fitHeight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(color: widgetColor)),
                                  onPressed: () async {
                                    bool? confirmTracking;
                                    if (onPress != null) {
                                      confirmTracking =
                                          await showFinishTrackingDialog(
                                              context);
                                    }
                                    if (confirmTracking == true) {
                                      await onPress!();
                                    }
                                  },
                                  child: Text('Finish',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: widgetColor,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ])
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Metric
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(leftValue,
                                            style: secondaryTextStyle),
                                        //const SizedBox(height: 5),
                                        //Text(leftMetricName, style: tertiaryStyle),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                // Right Metric
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(rightValue,
                                            style: secondaryTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Metric
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(leftMetricName,
                                            style: tertiaryStyle),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                // Right Metric
                                Expanded(
                                  flex: 1,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(rightMetricName,
                                            style: tertiaryStyle),
                                      ],
                                    ),
                                  ),
                                ),
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
