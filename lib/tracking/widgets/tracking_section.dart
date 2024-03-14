import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingSectionWidget extends StatelessWidget {
  const TrackingSectionWidget({super.key, required this.sectionName});

  final String sectionName;

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

  Widget sectionWidgets({required List<TrackingSummary> data}) {
    List<Widget> trackingWidgets = [];

    for (int i = 0; i < data.length; i++) {
      trackingWidgets.add(SimpleTrackingWidget(
        id: i,
        sectionTitle: data[i].section,
        trackingName: data[i].name,
        trackingCount: data[i].count,
        subtitle: data[i].subtitle,
      ));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
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
                sectionWidgets(data: state.trackingGroups[sectionName]!.data)
              ],
            );
          case TrackingStatus.failure:
            return const TrackingError();
        }
      },
    );
  }
}
