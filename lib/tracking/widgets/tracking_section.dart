import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingSectionWidget extends StatelessWidget {
  const TrackingSectionWidget({super.key, required this.sectionName});

  final String sectionName;

  Widget getTrackingWidget(
      {required int index,
      required TrackingSummary data,
      required ColorScheme colorScheme}) {
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
          trackingName: data.name,
          mainMetric: main,
          leftMetric: left,
          rightMetric: right,
          lastDate: data.records.last.date,
        );
      case "last_seven":
        color = colorScheme.secondary;
        return SimpleTrackingWidget(
          id: index,
          section: data.section,
          trackingName: data.name,
          mainMetric: main,
          leftMetric: left,
          rightMetric: right,
          color: color,
        );
      default:
        return SimpleTrackingWidget(
          id: index,
          section: data.section,
          trackingName: data.name,
          mainMetric: main,
          leftMetric: left,
          rightMetric: right,
        );
    }
  }

  Widget sectionHeader({
    required String sectionHeader,
    required TextStyle? textStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sectionHeader, style: textStyle),
          const Icon(Icons.menu),
        ],
      ),
    );
  }

  Widget sectionWidgets(
      {required List<TrackingSummary> data, required ColorScheme colorScheme}) {
    List<Widget> trackingWidgets = [];

    for (int i = 0; i < data.length; i++) {
      trackingWidgets.add(
          getTrackingWidget(index: i, data: data[i], colorScheme: colorScheme));
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
                sectionHeader(
                  sectionHeader: sectionHeaderString,
                  textStyle: sectionHeaderStyle,
                ),
                sectionWidgets(
                    data: state.trackingGroups[sectionName]!.data,
                    colorScheme: Theme.of(context).colorScheme)
              ],
            );
          case TrackingStatus.failure:
            return const TrackingError();
        }
      },
    );
  }
}
