///////////////////////////////////////////////////////////////////////////////
/// DEPRECATED: DO NOT USE
///////////////////////////////////////////////////////////////////////////////
// ignore_for_file: dangling_library_doc_comments
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

class OutlinedTrackingWidgetNonModular extends StatelessWidget {
  const OutlinedTrackingWidgetNonModular({
    super.key,
    required this.id,
    required this.section,
    required this.trackingName,
    required this.mainMetric,
    required this.onDoubleTap,
    Map<String, String>? leftMetric,
    Map<String, String>? rightMetric,
    this.clipBehavior,
    this.color,
  })  : leftMetric = leftMetric ?? const {"display_name": "", "value": ""},
        rightMetric = rightMetric ?? const {"display_name": "", "value": ""};

  final int id;
  final String section;
  final String trackingName;
  final Map<String, String> mainMetric;

  final Map<String, String> leftMetric;
  final Map<String, String> rightMetric;
  final Color? color;
  final void Function()? onDoubleTap;
  final Clip? clipBehavior;

  void _handleDefaultDoubleTap({required TrackingCubit trackingCubit}) {
    trackingCubit.addTrackingRecordAndUpdateSummary(
        section: section, index: id);
  }

  void _handleOnTap(buildContext, widget) async {
    await showDismissableModal(buildContext, widget);
  }

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit = context.read<TrackingCubit>();
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

    return GestureDetector(
      onDoubleTap: () {
        if (onDoubleTap != null) {
          onDoubleTap!();
        } else {
          _handleDefaultDoubleTap(trackingCubit: trackingCubit);
        }
      },
      onLongPress: () {
        _handleOnTap(context, TrackingDetailsView(id: id, section: section));
        trackingCubit.transitionUI();
      },
      onTap: () =>
          _handleOnTap(context, TrackingDetailsView(id: id, section: section)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shadowColor: widgetColor,
          clipBehavior: clipBehavior,
          child: SizedBox(
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
    );
  }
}
