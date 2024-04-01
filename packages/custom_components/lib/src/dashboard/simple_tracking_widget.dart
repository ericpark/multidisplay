import 'package:flutter/material.dart';

// Packages
import 'package:auto_size_text/auto_size_text.dart';

class SimpleTrackingWidget extends StatelessWidget {
  const SimpleTrackingWidget({
    super.key,
    required this.title,
    required this.mainMetric,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    this.color,
    this.size,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""};

  final String title;
  final Map<String, String> mainMetric;

  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;

  /// Color to override the theme colors
  final Color? color;

  /// Set the size of the widget.
  ///
  /// If not set, size of widget is set to an aspect ratio of 1:1 and will
  /// fill any available space provided by the parent.
  final Size? size;

  /// Called when the button is pressed.
  final VoidCallback? onTap;

  /// Called when the button is double tapped.
  final VoidCallback? onDoubleTap;

  /// Called when the button is long-pressed.
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final TextStyle centerStyle =
        Theme.of(context).primaryTextTheme.displayLarge!;
    final TextStyle primaryTextStyle =
        Theme.of(context).primaryTextTheme.headlineSmall!;
    final TextStyle secondaryTextStyle = Theme.of(context)
        .primaryTextTheme
        .labelLarge!
        .copyWith(fontWeight: FontWeight.bold);
    final TextStyle tertiaryStyle =
        Theme.of(context).primaryTextTheme.labelSmall!;

    final widgetColor = color ?? Theme.of(context).colorScheme.primary;

    // Set Metrics
    final String mainMetricName = mainMetric["display_name"] ?? "Not Found";
    final String mainValue = mainMetric["value"] ?? "-";

    final String leftMetricName = leftMetric["display_name"] ?? "";
    final String leftValue = leftMetric["value"] ?? "-";

    final String rightMetricName = rightMetric["display_name"] ?? "";
    final String rightValue = rightMetric["value"] ?? "-";

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          {}
        }
      },
      onDoubleTap: () {
        if (onDoubleTap != null) {
          onDoubleTap!();
        } else {
          {}
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress!();
        } else {
          {}
        }
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;
        print("$height, $width");

        final textScaleFactor = height / 200;
        return Align(
          // alignment: Alignment.centerLeft,
          child: SizedBox(
            height: size?.height,
            width: size?.width,
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: PhysicalModel(
                  color: Colors.white,
                  elevation: 2,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.33],
                          colors: [
                            widgetColor.withOpacity(0.70),
                            widgetColor,
                          ],
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(flex: 1),
                          Expanded(
                            flex: 5,
                            //padding: const EdgeInsets.only(top: 15.0),
                            child: FittedBox(
                              child: Text(
                                title,
                                style: primaryTextStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 11,

                            //padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mainValue,
                                  style: centerStyle,
                                  textScaler:
                                      TextScaler.linear(textScaleFactor - 0.1),
                                ),
                                FittedBox(
                                  child: Text(
                                    mainMetricName,
                                    style: tertiaryStyle,
                                    textScaler:
                                        TextScaler.linear(textScaleFactor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Expanded(
                            //padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                            child: Text(mainMetricName, style: tertiaryStyle),
                          ),*/
                          Spacer(flex: 1),
                          Expanded(
                            flex: 8,
                            /*padding: const EdgeInsets.only(
                                top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),*/
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          leftValue,
                                          style: secondaryTextStyle,
                                          textScaler: TextScaler.linear(
                                              textScaleFactor),
                                        ),
                                        //const SizedBox(height: 5),
                                        AutoSizeText(
                                          leftMetricName,
                                          maxLines: 2,
                                          style: tertiaryStyle,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor: textScaleFactor,
                                          textAlign: TextAlign.center,
                                          minFontSize: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(flex: 3),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          rightValue,
                                          style: secondaryTextStyle,
                                          textScaler: TextScaler.linear(
                                              textScaleFactor),
                                        ),
                                        //const SizedBox(height: 5),
                                        AutoSizeText(
                                          rightMetricName,
                                          maxLines: 2,
                                          style: tertiaryStyle,
                                          overflow: TextOverflow.ellipsis,
                                          textScaleFactor: textScaleFactor,
                                          textAlign: TextAlign.center,
                                          minFontSize: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
