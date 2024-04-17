import 'package:flutter/material.dart';
import 'dart:math';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

class ConfettiOutlinedTrackingWidget extends StatefulWidget {
  const ConfettiOutlinedTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    required this.onDoubleTap,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    bool? showConfetti,
    this.clipBehavior,
    this.color,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""},
        showConfetti = showConfetti ?? false;

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;

  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;
  final Future<bool?> Function()? onDoubleTap;
  final Clip? clipBehavior;
  final bool showConfetti;

  @override
  State<ConfettiOutlinedTrackingWidget> createState() =>
      _ConfettiOutlinedTrackingWidgetState();
}

class _ConfettiOutlinedTrackingWidgetState
    extends State<ConfettiOutlinedTrackingWidget> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 15));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  void _handleDefaultDoubleTap({required TrackingCubit trackingCubit}) {
    trackingCubit.handleWidgetDoubleTap(
        section: widget.section, index: widget.id);
  }

  void _handleOnTap(buildContext, widget) async {
    await showDismissableModal(buildContext, widget);
  }

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit = context.read<TrackingCubit>();
    final widgetColor = widget.color ?? Theme.of(context).colorScheme.primary;

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
    final String mainMetricName =
        widget.mainMetric["display_name"] ?? "Not Found";
    final String mainValue = widget.mainMetric["value"] ?? "-";

    final String leftMetricName = widget.leftMetric["display_name"] ?? "";
    final String leftValue = widget.leftMetric["value"] ?? "-";

    final String rightMetricName = widget.rightMetric["display_name"] ?? "";
    final String rightValue = widget.rightMetric["value"] ?? "-";

    return GestureDetector(
      onDoubleTap: () async {
        bool? confirmTracking;
        if (widget.onDoubleTap != null) {
          confirmTracking = await widget.onDoubleTap!();
        } else {
          _handleDefaultDoubleTap(trackingCubit: trackingCubit);
        }
        if (widget.showConfetti == true && confirmTracking == true) {
          _controllerCenter.play();
        }
      },
      onLongPress: () {
        _handleOnTap(context,
            TrackingDetailsView(id: widget.id, section: widget.section));
        trackingCubit.transitionUI();
      },
      onTap: () => _handleOnTap(
          context, TrackingDetailsView(id: widget.id, section: widget.section)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: widgetColor,
              clipBehavior: widget.clipBehavior,
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
                          widget.trackingName,
                          style: primaryTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                        child: Text(mainValue, style: centerStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                        child: Text(mainMetricName, style: tertiaryStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(leftValue, style: secondaryTextStyle),
                                const SizedBox(height: 5),
                                Text(leftMetricName, style: tertiaryStyle),
                              ],
                            ),
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
          ),
          ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ],
      ),
    );
  }
}
