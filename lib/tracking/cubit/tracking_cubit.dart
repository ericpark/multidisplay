import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';

part 'tracking_cubit.freezed.dart';
part 'tracking_cubit.g.dart';
part 'tracking_state.dart';

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit()
      : super(const TrackingState(
            status: TrackingStatus.initial, trackingGroups: {}));

  Future<void> init() async {
    emit(state.copyWith(status: TrackingStatus.loading));
    await fetchTrackingGroups();
    await getSections();
    emit(state.copyWith(status: TrackingStatus.success));
  }

  Future<List<String>> getSections() async {
    List<String> sections = [];

    //await Future.delayed(const Duration(milliseconds: 1));
    sections = ["Meeko", "Gym", "Personal"];
    emit(state.copyWith(trackingSections: sections));
    return sections;
  }

  Future<TrackingGroup> getTrackingDataForSection(
      {required String section}) async {
    List<TrackingSummary> trackingSummaries = [];

    TrackingSummary trackingData = TrackingSummary(
        name: "Meeko",
        section: section,
        subtitle: "Days Since Last",
        left: "03/13/24",
        right: "03/15/24");
    TrackingSummary defaultTrackingData = TrackingSummary(
        name: "Tracking Name",
        section: section,
        subtitle: "subtitle",
        left: "left",
        right: "right");

    //await Future.delayed(const Duration(seconds: 1));
    trackingSummaries = [
      trackingData,
      defaultTrackingData,
      defaultTrackingData,
    ];

    return TrackingGroup(name: section, data: trackingSummaries);
  }

  Future<void> fetchTrackingGroups() async {
    Map<String, TrackingGroup> groups = {};
    final section = await getTrackingDataForSection(section: "Meeko");
    groups["Meeko"] = section;
    final exampleSection = await getTrackingDataForSection(section: "Gym");
    groups["Gym"] = exampleSection;
    groups["Personal"] = await getTrackingDataForSection(section: "Personal");

    //final trackingGroups = [section, exampleSection, exampleSection];
    emit(
        state.copyWith(status: TrackingStatus.success, trackingGroups: groups));
  }

  Future<void> updateCountForTrackingSummary(
      {required String section, required int index}) async {
    Map<String, dynamic> json = state.toJson();

    Map<String, TrackingGroup> trackingGroups =
        state.copyWith(trackingGroups: state.trackingGroups).trackingGroups;
    TrackingGroup trackingGroup = trackingGroups[section]!;
    TrackingSummary trackingSummary = trackingGroup.data[index];

    TrackingSummary updatedTrackingSummary =
        trackingSummary.copyWith(count: trackingSummary.count + 1);

    TrackingGroup updatedTrackingGroup = trackingGroup.copyWith(data: [
      ...trackingGroup.data.sublist(0, index),
      updatedTrackingSummary,
      ...trackingGroup.data.sublist(index + 1)
    ]);

    json["tracking_groups"][section] = updatedTrackingGroup.toJson();
    final updatedState = TrackingState.fromJson(json);

    emit(state.copyWith(
        status: TrackingStatus.success,
        trackingGroups: updatedState.trackingGroups));
  }

  Future<void> reorderSections({
    required int oldIndex,
    required int newIndex,
  }) async {
    List<String> newOrder = [];

    // Moved item down the list
    if (oldIndex < newIndex) {
      for (int before = 0; before < oldIndex; before++) {
        newOrder.add(state.trackingSections[before]);
      }
      if (newIndex == state.trackingSections.length) {
        newOrder = [
          ...newOrder,
          ...state.trackingSections.sublist(oldIndex + 1),
          state.trackingSections[oldIndex]
        ];
      } else {
        for (int after = oldIndex + 1; after < newIndex; after++) {
          newOrder.add(state.trackingSections[after]);
        }
        newOrder.add(state.trackingSections[oldIndex]);
        for (int after = newIndex;
            after < state.trackingSections.length;
            after++) {
          newOrder.add(state.trackingSections[after]);
        }
      }
    }
    // Moved item up the list
    else if (oldIndex > newIndex) {
      if (newIndex == 0) {
        newOrder = [
          state.trackingSections[oldIndex],
          ...state.trackingSections.sublist(0, oldIndex),
          ...state.trackingSections.sublist(oldIndex + 1),
        ];
      } else {
        for (int before = 0; before < newIndex; before++) {
          newOrder.add(state.trackingSections[before]);
        }
        newOrder.add(state.trackingSections[oldIndex]);
        for (int after = newIndex; after < oldIndex; after++) {
          newOrder.add(state.trackingSections[after]);
        }
        for (int after = oldIndex + 1;
            after < state.trackingSections.length;
            after++) {
          newOrder.add(state.trackingSections[after]);
        }
      }
    }

    emit(state.copyWith(
        status: TrackingStatus.success, trackingSections: newOrder));
  }
}
