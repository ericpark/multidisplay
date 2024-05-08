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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shadowColor: widgetColor,
        child: SizedBox(
          //TODO: Make this dynamic
          height: 200,
          width: 200,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
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
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                      child: Text(mainValue, style: centerStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                      child: Text(mainMetricName, style: tertiaryStyle),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: isActive
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: isActive
                        ? [
                            SizedBox(
                              height: 20,
                              width: 180,
                              child: Center(
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
                                  child: Text(
                                    'Finish',
                                    style: secondaryTextStyle.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        : [
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
