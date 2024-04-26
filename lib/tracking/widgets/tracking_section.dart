import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/tracking/widgets/tw_last_nth.dart';
import 'package:multidisplay/tracking/widgets/tw_nth_ago.dart';

class TrackingSectionWidget extends StatelessWidget {
  const TrackingSectionWidget({super.key, required this.sectionName});

  final String sectionName;

  Widget getTrackingWidget({
    required int index,
    required TrackingSummary data,
    required ColorScheme colorScheme,
    required TrackingCubit trackingCubit,
  }) {
    final main =
        data.metrics[data.mainMetric] ?? {"display_name": "", "value": ""};
    final left = data.metrics[data.leftMetric];
    final right = data.metrics[data.rightMetric];

    Color? color;

    switch (data.trackingType) {
      case "consecutive":
        return ConsecutiveTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => await trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
          //dialogChoices: ["Leg", "chest"],
        );
      case "last_seven":
        color = colorScheme.primary;

        return LastNthTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => await trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
          color: color,

          //dialogChoices: ["Leg", "chest"],
        );
      case "fixed_week":
        color = colorScheme.secondary;
        return FixedWeekTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          remaining: int.tryParse(main["value"] ?? "") ?? 0,
          onDoubleTap: () => trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
        );
      case "days_ago":
        color = colorScheme.secondary;
        return NthAgoTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () => trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
        );
      case "test":
        color = colorScheme.secondary;
        return OutlinedTrackingWidget(
          id: index,
          section: data.section,
          trackingName: data.name,
          mainMetric: main,
          leftMetric: left,
          rightMetric: right,
          onDoubleTap: () => trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
        );
      default:
        return OutlinedTrackingWidget(
          id: index,
          section: data.section,
          trackingName: data.name,
          mainMetric: main,
          leftMetric: left,
          rightMetric: right,
          onDoubleTap: () async => await trackingCubit.handleWidgetDoubleTap(
              section: data.section, index: index),
        );
    }
  }

  Widget sectionHeader({
    required String sectionHeader,
    required TextStyle? textStyle,
    required bool reorderable,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sectionHeader, style: textStyle),
          reorderable ? const Icon(Icons.menu) : Container(),
        ],
      ),
    );
  }

  Widget sectionWidgets(
      {required List<TrackingSummary> data,
      required ColorScheme colorScheme,
      required TrackingCubit trackingCubit}) {
    List<Widget> trackingWidgets = [];

    for (int i = 0; i < data.length; i++) {
      trackingWidgets.add(getTrackingWidget(
          index: i,
          data: data[i],
          colorScheme: colorScheme,
          trackingCubit: trackingCubit));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return trackingWidgets[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String sectionHeaderString = sectionName;
    final sectionHeaderStyle = Theme.of(context).textTheme.titleLarge;
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        TrackingCubit trackingCubit = context.read<TrackingCubit>();
        switch (state.status) {
          case TrackingStatus.initial:
            return const TrackingEmpty();
          case TrackingStatus.loading:
            return const TrackingLoading();
          case TrackingStatus.success || TrackingStatus.transitioning:
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: sectionHeader(
                      sectionHeader: sectionHeaderString,
                      textStyle: sectionHeaderStyle,
                      reorderable: state.reorderable),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                sectionWidgets(
                    data: state.trackingGroups[sectionName]?.data ?? [],
                    colorScheme: Theme.of(context).colorScheme,
                    trackingCubit: trackingCubit),
              ],
            );
          case TrackingStatus.failure:
            return const TrackingError();
        }
      },
    );
  }
}
