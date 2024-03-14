import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

class SimpleTrackingWidget extends StatelessWidget {
  const SimpleTrackingWidget({
    super.key,
    required this.id,
    String? sectionTitle,
    String? trackingName,
    int? trackingCount,
    String? subtitle,
    String? left,
    String? right,
  })  : sectionTitle = sectionTitle ?? "SECTION TITLE",
        trackingName = trackingName ?? "TRACKING NAME",
        trackingCount = trackingCount ?? 0,
        subtitle = subtitle ?? "SUBTITLE",
        left = left ?? "LEFT",
        right = right ?? "RIGHT";

  final int id;
  final String sectionTitle;
  final String trackingName;
  final int trackingCount;
  final String subtitle;
  final String left;
  final String right;

  void _handleDoubleTap({required TrackingCubit trackingCubit}) {
    trackingCubit.updateCountForTrackingSummary(
        section: sectionTitle, index: id);
  }

  void _handleLongPress(buildContext, widget) async {
    await showDismissableModal(buildContext, widget);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle centerStyle =
        Theme.of(context).primaryTextTheme.displayLarge!;

    TrackingCubit trackingCubit = context.read<TrackingCubit>();
    return GestureDetector(
      onDoubleTap: () => _handleDoubleTap(trackingCubit: trackingCubit),
      onLongPress: () => _handleLongPress(context, Container()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
          color: Theme.of(context).primaryColor,
          elevation: 0,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
              height: 200,
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Align(alignment: Alignment.centerLeft, child: Text("")),
                  ),
                  Text(trackingName),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("$trackingCount", style: centerStyle),
                  ),
                  Text(subtitle),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(left),
                        Text(right),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
