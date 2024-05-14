import 'package:flutter/material.dart';

class OutlinedTrackingWidgetAuto extends StatelessWidget {
  const OutlinedTrackingWidgetAuto({
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
    final centerLabelStyle = Theme.of(context)
        .primaryTextTheme
        .labelLarge!
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

    var leftMetricName = leftMetric['display_name'] ?? '';
    var leftValue = leftMetric['value'] ?? '-';

    var rightMetricName = rightMetric['display_name'] ?? '';
    var rightValue = rightMetric['value'] ?? '-';

    // Must set with a space if empty to avoid scaling issues
    if (leftMetricName == '') {
      leftMetricName = ' ';
      leftValue = ' ';
    }
    if (rightMetricName == '') {
      rightMetricName = ' ';
      rightValue = ' ';
    }
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
                        Text(mainMetricName, style: centerLabelStyle),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
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
                                  Text(leftValue, style: secondaryTextStyle),
                                  //const SizedBox(height: 5),
                                  //Text(leftMetricName, style: tertiaryStyle),
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
                                  Text(rightValue, style: secondaryTextStyle),
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
                                  Text(leftMetricName, style: tertiaryStyle),
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
                                  Text(rightMetricName, style: tertiaryStyle),
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
