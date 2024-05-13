import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingSectionWidget extends StatelessWidget {
  const TrackingSectionWidget({
    super.key,
    required this.sectionName,
    this.fadeInCallback,
  });

  final String sectionName;
  final Function(String)? fadeInCallback;

  Widget getTrackingWidget({
    required int index,
    required TrackingSummary data,
    required ColorScheme colorScheme,
    required TrackingCubit trackingCubit,
  }) {
    Color? color;

    void onDoubleTapWrapper() async {
      await trackingCubit.addTrackingRecordAndUpdateSummary(
          section: data.section, index: index);

      //if (fadeInCallback != null) fadeInCallback!("");
    }

    switch (data.trackingType) {
      case "consecutive":
        return ConsecutiveTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
        );
      case "last_seven":
        color = colorScheme.primary;

        return LastNthTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
          color: color,
        );
      case "fixed_week":
        color = colorScheme.secondary;
        return FixedNthTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
        );
      case "days_ago":
        color = colorScheme.secondary;

        return NthAgoTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
        );
      /*case "test":
        color = colorScheme.secondary;
        return NthAgoTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
        );*/
      case "time":
        color = colorScheme.secondary;
        return TimeTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
          onFinished: () => trackingCubit.recordFinishTime(
              section: data.section, index: index),
        );

      default:
        color = colorScheme.secondary;
        return DefaultTrackingWidget(
          id: index,
          section: data.section,
          trackingSummary: data,
          onDoubleTap: () async => onDoubleTapWrapper(),
          color: color,
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

  Widget sectionWidgets({
    required List<TrackingSummary> data,
    required ColorScheme colorScheme,
    required TrackingCubit trackingCubit,
  }) {
    List<Widget> trackingWidgets = [];
    for (int i = 0; i < data.length; i++) {
      trackingWidgets.add(getTrackingWidget(
          index: i,
          data: data[i],
          colorScheme: colorScheme,
          trackingCubit: trackingCubit));
    }
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return trackingWidgets[index];
      },
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
                    reorderable: state.reorderable,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 200,
                  child: sectionWidgets(
                    data: state.trackingGroups[sectionName]?.data ?? [],
                    colorScheme: Theme.of(context).colorScheme,
                    trackingCubit: trackingCubit,
                  ),
                )
              ],
            );
          case TrackingStatus.failure:
            return const TrackingError();
        }
      },
    );
  }
}
