///////////////////////////////////////////////////////////////////////////////
/// DEPRECATED: DO NOT USE
///////////////////////////////////////////////////////////////////////////////
// ignore_for_file: dangling_library_doc_comments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class FixedWeekTrackingWidget extends StatelessWidget {
  const FixedWeekTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingSummary,
    required this.onDoubleTap,
    required this.remaining,
    this.dialogChoices,
  });

  final int id;
  final String section;
  final TrackingSummary trackingSummary;
  final int remaining;

  final List<String>? dialogChoices;
  final void Function()? onDoubleTap;
  void _showDefaultDialog(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Track Event',
      message: 'Do you want to add this event?',
      okLabel: 'Yes',
      cancelLabel: 'No',
      isDestructiveAction: false,
      builder: (context, child) => Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),

          // If this is commented out, the color for cupertino will be default blue/red.
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
        ),
        child: child,
      ),
    );
    if (result == OkCancelResult.ok) {
      onDoubleTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? color;

    final trackingName = trackingSummary.name;
    final mainMetric = trackingSummary.metrics[trackingSummary.mainMetric] ??
        {"display_name": "", "value": ""};
    final leftMetric = trackingSummary.metrics[trackingSummary.leftMetric] ??
        const {"display_name": "", "value": ""};
    final rightMetric = trackingSummary.metrics[trackingSummary.rightMetric] ??
        const {"display_name": "", "value": ""};
    final threshold = [1, 0];
    if (remaining >= threshold[0]) {
      color = Colors.green[700];
    } else if (remaining >= threshold[1]) {
      color = Colors.amber[700];
    } else {
      color = Colors.red[700];
    }

    return OutlinedTrackingWidgetNonModular(
      id: id,
      section: section,
      trackingName: trackingName,
      mainMetric: mainMetric,
      leftMetric: leftMetric,
      rightMetric: rightMetric,
      color: color,
      onDoubleTap: () => _showDefaultDialog(context),
    );
  }
}
