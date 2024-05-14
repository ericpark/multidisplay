///////////////////////////////////////////////////////////////////////////////
/// DEPRECATED: DO NOT USE
///////////////////////////////////////////////////////////////////////////////
import 'dart:math';

// ignore_for_file: dangling_library_doc_comments
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/app/widgets/dismissable_modal.dart';
// Project
import 'package:multidisplay/tracking/tracking.dart';

class OutlinedTrackingButtonWidget extends StatefulWidget {
  const OutlinedTrackingButtonWidget({
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    required this.onDoubleTap,
    required this.onTrackingEnds,
    required this.onFinished,
    required this.isTracking,
    super.key,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    bool? showConfetti,
    String? confettiType,
    this.clipBehavior,
    this.color,
  })  : leftMetric = leftMetric ?? const {'display_name': '', 'value': ''},
        rightMetric = rightMetric ?? const {'display_name': '', 'value': ''},
        showConfetti = showConfetti ?? false,
        confettiType = confettiType ?? 'star';

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;

  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;
  final Future<bool?> Function()? onDoubleTap;
  final Future<bool?> Function()? onTrackingEnds;
  final Future<void> Function()? onFinished;
  final bool showConfetti;

  final Clip? clipBehavior;
  final bool isTracking;
  final String confettiType;

  @override
  State<OutlinedTrackingButtonWidget> createState() =>
      _OutlinedTrackingButtonWidgetState();
}

class _OutlinedTrackingButtonWidgetState
    extends State<OutlinedTrackingButtonWidget> {
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

    for (var step = 0.0; step < fullAngle; step += degreesPerStep) {
      path
        ..lineTo(
          halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step),
        )
        ..lineTo(
          halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep),
        );
    }
    path.close();
    return path;
  }

  Path drawHeart(Size size) {
    final path = Path();

    final width = size.width;
    final height = size.height;

    // Modify the path to draw a heart shape
    path
      ..moveTo(0.5 * width, height * 0.35)
      ..cubicTo(
        0.2 * width,
        height * 0.1,
        -0.05 * width,
        height * 0.6,
        0.5 * width,
        height,
      )
      ..moveTo(0.5 * width, height * 0.35)
      ..cubicTo(
        0.8 * width,
        height * 0.1,
        1.05 * width,
        height * 0.6,
        0.5 * width,
        height,
      );

    return path;
  }

  void _handleDefaultDoubleTap({required TrackingCubit trackingCubit}) {
    trackingCubit.addTrackingRecordAndUpdateSummary(
      section: widget.section,
      index: widget.id,
    );
  }

  Future<void> _handleOnTap(BuildContext buildContext, Widget widget) async {
    await showDismissableModal(buildContext, widget);
  }

  @override
  Widget build(BuildContext context) {
    final trackingCubit = context.read<TrackingCubit>();
    final widgetColor = widget.color ?? Theme.of(context).colorScheme.primary;

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
    final mainMetricName = widget.mainMetric['display_name'] ?? 'Not Found';
    final mainValue = widget.mainMetric['value'] ?? '-';

    final leftMetricName = widget.leftMetric['display_name'] ?? '';
    final leftValue = widget.leftMetric['value'] ?? '-';

    final rightMetricName = widget.rightMetric['display_name'] ?? '';
    final rightValue = widget.rightMetric['value'] ?? '-';

    final confettiColors = widget.confettiType == 'star'
        ? [
            Colors.blue,
            Colors.green,
            Colors.red,
            Colors.yellow,
            Colors.purple,
          ]
        : widget.confettiType == 'heart'
            ? const [
                Colors.pink,
                Colors.red,
              ]
            : null;
    final confettiShape = widget.confettiType == 'star'
        ? drawStar
        : widget.confettiType == 'heart'
            ? drawHeart
            : null;
    return GestureDetector(
      onDoubleTap: () async {
        if (widget.isTracking) return;

        bool? confirmTracking;

        if (widget.onDoubleTap != null) {
          confirmTracking = await widget.onDoubleTap!();
        } else {
          _handleDefaultDoubleTap(trackingCubit: trackingCubit);
        }
        if (widget.showConfetti == true && (confirmTracking ?? false)) {
          _controllerCenter.play();
        }
      },
      onLongPress: () {
        _handleOnTap(
          context,
          TrackingDetailsView(id: widget.id, section: widget.section),
        );
        trackingCubit.transitionUI();
      },
      onTap: () => (rightValue == '')
          ? {}
          : _handleOnTap(
              context,
              TrackingDetailsView(id: widget.id, section: widget.section),
            ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: widgetColor,
              clipBehavior: widget.clipBehavior,
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
                          widget.trackingName,
                          style: primaryTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(mainValue, style: centerStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(mainMetricName, style: tertiaryStyle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 5,
                          left: 5,
                          right: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: (rightValue == '')
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceBetween,
                          children: (rightValue == '')
                              ? [
                                  SizedBox(
                                    height: 20,
                                    width: 180,
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(color: widgetColor),
                                        ),
                                        onPressed: () async {
                                          bool? confirmTracking;
                                          if (widget.onTrackingEnds != null) {
                                            confirmTracking =
                                                await widget.onTrackingEnds!();
                                          }
                                          if (widget.showConfetti == true &&
                                              (confirmTracking ?? false)) {
                                            _controllerCenter.play();
                                            await widget.onFinished!();
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
                                  ),
                                ]
                              : [
                                  Column(
                                    children: [
                                      Text(
                                        leftValue,
                                        style: secondaryTextStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        leftMetricName,
                                        style: tertiaryStyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        rightValue,
                                        style: secondaryTextStyle,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        rightMetricName,
                                        style: tertiaryStyle,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  minBlastForce: 20,
                  maxBlastForce: 50,
                  gravity: 0.01,
                  particleDrag: 0.15,
                  colors:
                      confettiColors, // manually specify the colors to be used
                  createParticlePath:
                      confettiShape, // define a custom shape/path.
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
