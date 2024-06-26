import 'package:flutter/material.dart';
import 'package:multidisplay/tracking/tracking.dart';

class OutlinedTrackingWithButtonWidget extends StatelessWidget
    with TrackingDialog {
  const OutlinedTrackingWithButtonWidget({
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    super.key,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    this.color,
    this.isActive = false,
    this.onPress,
  })  : leftMetric = leftMetric ?? const {'display_name': '', 'value': ''},
        rightMetric = rightMetric ?? const {'display_name': '', 'value': ''};

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

    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: widgetColor,
      child: SizedBox.expand(
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                  side: BorderSide(color: widgetColor),
                                ),
                                onPressed: () async {
                                  bool? confirmTracking;
                                  if (onPress != null) {
                                    confirmTracking =
                                        await showFinishTrackingDialog(
                                      context,
                                    );
                                  }
                                  if (confirmTracking ?? false) {
                                    await onPress!();
                                  }
                                },
                                child: Text(
                                  'Finish',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: widgetColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Metric
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          leftValue,
                                          style: secondaryTextStyle,
                                        ),
                                        //const SizedBox(height: 5),
                                        //Text(leftMetricName,
                                        //style: tertiaryStyle,),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Right Metric
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          rightValue,
                                          style: secondaryTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Metric
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          leftMetricName,
                                          style: tertiaryStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Right Metric
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          rightMetricName,
                                          style: tertiaryStyle,
                                        ),
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
