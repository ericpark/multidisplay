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
    this.isPrivate,
    this.isRestricted,
    this.isFavorite,
  })  : leftMetric = leftMetric ?? const {'display_name': '', 'value': ''},
        rightMetric = rightMetric ?? const {'display_name': '', 'value': ''};

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;
  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;
  final bool? isPrivate;
  final bool? isRestricted;
  final bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    final widgetColor = color ?? Theme.of(context).colorScheme.primary;
    const cardColor = Colors.white;
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
      color: cardColor,
      elevation: 5,
      shadowColor: widgetColor,
      child: SizedBox.expand(
        child: ColoredBox(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: _WidgetIcons(
                    backgroundColor: cardColor,
                    isPrivate: isPrivate,
                    isRestricted: isRestricted,
                    isFavorite: isFavorite,
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: _WidgetTitle(
                    trackingName: trackingName,
                    primaryTextStyle: primaryTextStyle,
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: _WidgetMainMetric(
                    mainValue: mainValue,
                    centerStyle: centerStyle,
                    mainMetricName: mainMetricName,
                    centerLabelStyle: centerLabelStyle,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: _WidgetAdditionalMetrics(
                    leftValue: leftValue,
                    secondaryTextStyle: secondaryTextStyle,
                    rightValue: rightValue,
                    leftMetricName: leftMetricName,
                    tertiaryStyle: tertiaryStyle,
                    rightMetricName: rightMetricName,
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

class _WidgetAdditionalMetrics extends StatelessWidget {
  const _WidgetAdditionalMetrics({
    required this.leftValue,
    required this.secondaryTextStyle,
    required this.rightValue,
    required this.leftMetricName,
    required this.tertiaryStyle,
    required this.rightMetricName,
  });

  final String leftValue;
  final TextStyle secondaryTextStyle;
  final String rightValue;
  final String leftMetricName;
  final TextStyle tertiaryStyle;
  final String rightMetricName;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _WidgetMainMetric extends StatelessWidget {
  const _WidgetMainMetric({
    required this.mainValue,
    required this.centerStyle,
    required this.mainMetricName,
    required this.centerLabelStyle,
  });

  final String mainValue;
  final TextStyle centerStyle;
  final String mainMetricName;
  final TextStyle centerLabelStyle;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(mainValue, style: centerStyle),
          Text(mainMetricName, style: centerLabelStyle),
        ],
      ),
    );
  }
}

class _WidgetIcons extends StatelessWidget {
  const _WidgetIcons({
    required this.backgroundColor,
    bool? isPrivate = false,
    bool? isRestricted = false,
    bool? isFavorite = false,
  })  : isPrivate = isPrivate ?? false,
        isRestricted = isRestricted ?? false,
        isFavorite = isFavorite ?? false;

  final Color backgroundColor;
  final bool isPrivate;
  final bool isRestricted;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final empty = !isPrivate && !isRestricted && !isFavorite;
    final iconColor = Colors.grey[400];
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      if (isPrivate)
                        Icon(
                          Icons.person,
                          color: iconColor,
                        ),
                      if (isRestricted)
                        Icon(
                          Icons.lock,
                          color: iconColor,
                        ),
                      if (isFavorite)
                        Icon(
                          Icons.star,
                          color: iconColor,
                        ),
                      if (empty)
                        Icon(
                          Icons.public,
                          color: backgroundColor,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            /* Use if one icon should be separated from the rest
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(Icons.star),
              ),*/
          ],
        ),
      ),
    );
  }
}

class _WidgetTitle extends StatelessWidget {
  const _WidgetTitle({
    required this.trackingName,
    required this.primaryTextStyle,
  });

  final String trackingName;
  final TextStyle primaryTextStyle;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
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
    );
  }
}
