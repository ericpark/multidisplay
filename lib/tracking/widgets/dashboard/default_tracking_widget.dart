import 'package:flutter/material.dart';

// Packages
import 'package:multidisplay/app/widgets/dismissable_modal.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class DefaultTrackingWidget extends StatefulWidget
    with TrackingWidget, TrackingDialog {
  DefaultTrackingWidget({
    required this.onDoubleTap,
    required int id,
    required String section,
    required TrackingSummary trackingSummary,
    super.key,
    this.color,
  }) {
    // Confetti Mixin
    this.id = id;
    this.section = section;
    this.trackingSummary = trackingSummary;
  }

  final void Function()? onDoubleTap;
  final Color? color;
  @override
  State<DefaultTrackingWidget> createState() => DefaultTrackingWidgetState();
}

class DefaultTrackingWidgetState<T extends DefaultTrackingWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onDoubleTap() async {
    // Do nothing if no double tap function is provided
    if (widget.onDoubleTap == null) return;

    // Check confirmation and stop if not confirmed
    final confirmTracking = await widget.showDefaultDialog(
      context,
      onDoubleTap: widget.onDoubleTap,
    );
    if (confirmTracking != true) return;
  }

  Future<void> displayDetailsPage() async {
    await showDismissableModal(
      context,
      TrackingDetailsView(id: widget.id, section: widget.section),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trackingName = widget.trackingSummary.name;
    final mainMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.mainMetric] ??
            widget.emptyMetric;
    final leftMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.leftMetric] ??
            widget.emptyMetric;
    final rightMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            widget.emptyMetric;

    final isRestricted = widget.trackingSummary.restricted;
    final isPrivate = widget.trackingSummary.private;

    final color = widget.color;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onDoubleTap: () async => onDoubleTap(),
          onLongPress: () async => displayDetailsPage(),
          onTap: () async => displayDetailsPage(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  OutlinedTrackingWidgetAuto(
                    id: widget.id,
                    section: widget.section,
                    trackingName: trackingName,
                    mainMetric: mainMetric,
                    leftMetric: leftMetric,
                    rightMetric: rightMetric,
                    color: color,
                    isRestricted: isRestricted,
                    isPrivate: isPrivate,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
