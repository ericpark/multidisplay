import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:tracking_repository/tracking_repository.dart'
    show TrackingRepository;
part 'tracking_cubit.freezed.dart';
part 'tracking_cubit.g.dart';
part 'tracking_state.dart';
part 'tracking_cubit_consecutive.dart';
part 'tracking_cubit_last_seven.dart';
part 'tracking_cubit_days_since.dart';
part 'tracking_cubit_fixed_week.dart';
part 'tracking_cubit_tracking_widgets.dart';

class TrackingCubit extends HydratedCubit<TrackingState> {
  TrackingCubit(this._trackingRepository)
      : super(const TrackingState(
            status: TrackingStatus.initial, trackingGroups: {}));

  final TrackingRepository _trackingRepository;
  Future<void> init() async {
    emit(state.copyWith(status: TrackingStatus.loading));
    await fetchTrackingGroups();
    await getSections();
    emit(state.copyWith(status: TrackingStatus.success));
  }

  Future<void> getSections() async {
    List<String> sections = [];

    //await Future.delayed(const Duration(milliseconds: 1));
    sections = state.trackingSections;
    //sections = ["Meeko", "Gym", "Home", "Money", "Health"];

    if (sections.isEmpty) {
      //TODO: GET Tracking groups
      sections = ["Meeko", "Gym", "Home", "Money", "Health"];
    }

    emit(state.copyWith(trackingSections: sections));
  }

  Future<TrackingGroup> getTrackingDataForSection(
      {required String section}) async {
    List<TrackingSummary> trackingSummaries = [];

    final repoSummaries =
        await _trackingRepository.getTrackingSummariesByOwnerIdForSection(
            userId: "default", section: section);

    trackingSummaries = repoSummaries
        .map((summary) => TrackingSummary.fromRepository(summary))
        .toList();

    for (var index = 0; index < trackingSummaries.length; index++) {
      TrackingSummary summary = trackingSummaries[index];
      if (summary.autoUpdate) {
        TrackingSummary updatedTrackingSummary =
            await updateTrackingSummaryMetrics(trackingSummary: summary);
        trackingSummaries[index] = updatedTrackingSummary;
        bool updated = !(const DeepCollectionEquality()
            .equals(updatedTrackingSummary.metrics, summary.metrics));

        if (updated) {
          await _trackingRepository.updateTrackingSummary(
              trackingSummaryId: updatedTrackingSummary.id,
              data: updatedTrackingSummary.toRepository().toJson());
        }
      }
    }

    return TrackingGroup(name: section, data: trackingSummaries);
  }

  Future<void> fetchTrackingGroups() async {
    emit(state.copyWith(status: TrackingStatus.loading));
    Map<String, TrackingGroup> groups = {};

    for (var sectionName in state.trackingSections) {
      TrackingGroup data =
          await getTrackingDataForSection(section: sectionName);
      groups[sectionName] = data;
    }

    emit(
        state.copyWith(status: TrackingStatus.success, trackingGroups: groups));
  }

  TrackingSummary indexToTrackingSummary(
      {required String section, required int index}) {
    TrackingGroup trackingGroup = state.trackingGroups[section]!;
    return trackingGroup.data[index];
  }

  Future<TrackingRecord> addTrackingRecord(
      {required String trackingSummaryId, DateTime? date}) async {
    final newRecord = TrackingRecord(date: date ?? DateTime.now());
    final trackingData = newRecord.toRepository();
    final createdRecord =
        await _trackingRepository.addTrackingRecordsForTrackingSummary(
            trackingSummaryId: trackingSummaryId, trackingData: trackingData);
    return createdRecord != null
        ? TrackingRecord.fromJson(createdRecord.toJson())
        : newRecord; //TODO: Does this work?
  }

  Future<void> refreshTrackingSummariesOnNewDay() async {
    //emit(state.copyWith(status: TrackingStatus.loading));
    bool requiresUpdate = false;

    DateTime now = DateTime.now();
    Map<String, TrackingGroup> updatedTrackingGroups = {
      ...state.trackingGroups
    };
    //print("$updatedTrackingGroups");

    for (int index = 0; index < state.trackingSections.length; index++) {
      var section = state.trackingSections[index];
      // print("$section");

      List<TrackingSummary> trackingSummaries = [
        ...(state.trackingGroups[section]?.data ?? [])
      ];
      //print("$trackingSummaries");

      if (trackingSummaries.isEmpty) {
        break;
      }
      for (var summary = 0; summary < trackingSummaries.length; summary++) {
        var trackingSummary = trackingSummaries[summary];
        if (!trackingSummary.autoUpdate) {
          break;
        }
        bool fetchedToday = trackingSummary.fetchedAt!.year == now.year &&
            trackingSummary.fetchedAt!.month == now.month &&
            trackingSummary.fetchedAt!.day == now.day;

        if (!fetchedToday) {
          requiresUpdate = true;
          var updatedTrackingSummary = TrackingSummary.fromRepository(
              (await _trackingRepository.getTrackingSummaryById(
                  trackingSummaryId: trackingSummary.id))!);

          trackingSummaries[summary] = updatedTrackingSummary;
        }
      }
      updatedTrackingGroups.update(section,
          (trackingGroup) => trackingGroup.copyWith(data: trackingSummaries));
    }

    if (requiresUpdate) {
      emit(state.copyWith(
          status: TrackingStatus.success,
          trackingGroups: updatedTrackingGroups));
    }
  }

  Future<TrackingSummary> updateTrackingSummaryMetrics(
      {required TrackingSummary trackingSummary}) async {
    TrackingSummary updatedTrackingSummary;

    List<TrackingRecord> records =
        (await _trackingRepository.getTrackingRecordsForTrackingSummary(
                trackingSummaryId: trackingSummary.id))
            .map((rec) => TrackingRecord.fromJson(rec.toJson()))
            .toList();

    switch (trackingSummary.trackingType) {
      case "consecutive":
        updatedTrackingSummary = incrementConsecutiveTracker(
            trackingSummary: trackingSummary.copyWith(records: records));
      case "last_seven":
        updatedTrackingSummary = incrementLastSevenTracker(
            trackingSummary: trackingSummary.copyWith(records: records));
      case "days_ago":
        updatedTrackingSummary = incrementDaysSince(
            trackingSummary: trackingSummary.copyWith(records: records));
      case "fixed_week":
        updatedTrackingSummary = decrementFixedWeekTracker(
            trackingSummary: trackingSummary.copyWith(records: records));
      default:
        updatedTrackingSummary = trackingSummary;
    }
    return updatedTrackingSummary;
  }

  Future<void> handleWidgetDoubleTap(
      {required String section, required int index}) async {
    TrackingSummary trackingSummary =
        indexToTrackingSummary(section: section, index: index);

    if (trackingSummary.id == "") {
      return;
    }

    await addTrackingRecord(trackingSummaryId: trackingSummary.id);

    TrackingSummary updatedTrackingSummary =
        await updateTrackingSummaryMetrics(trackingSummary: trackingSummary);

    /*TrackingGroup trackingGroup = state.trackingGroups[section]!;
    TrackingGroup updatedTrackingGroup = trackingGroup.copyWith(data: [
      ...trackingGroup.data.sublist(0, index),
      updatedTrackingSummary,
      ...trackingGroup.data.sublist(index + 1)
    ]);*/

    Map<String, TrackingGroup> updatedTrackingGroups = {
      ...state.trackingGroups
    };
    updatedTrackingGroups.update(
        section,
        (trackingGroup) => trackingGroup.copyWith(data: [
              ...trackingGroup.data.sublist(0, index),
              updatedTrackingSummary,
              ...trackingGroup.data.sublist(index + 1)
            ]));

    await _trackingRepository.updateTrackingSummary(
        trackingSummaryId: updatedTrackingSummary.id,
        data: updatedTrackingSummary.toRepository().toJson());

    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }

  Future<void> deleteTrackingRecord({
    required String trackingSummaryId,
    required String trackingRecordId,
    required String section,
  }) async {
    if (trackingSummaryId == "") {
      return;
    }
    if (trackingRecordId == "") {
      return;
    }
    _trackingRepository.deleteTrackingRecord(
        trackingSummaryId: trackingSummaryId,
        trackingRecordId: trackingRecordId);

    Map<String, TrackingGroup> updatedTrackingGroups = {
      ...state.trackingGroups
    };
    updatedTrackingGroups.update(
        section,
        (trackingGroup) => trackingGroup.copyWith(
            data: trackingGroup.data
                .where((record) => record.id != trackingRecordId)
                .toList()));
    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }

  Future<void> updateTrackingRecord({
    required TrackingSummary trackingSummary,
    required TrackingRecord trackingRecord,
    required data,
  }) async {
    if (trackingSummary.id == "") {
      return;
    }
    if (trackingRecord.id == "") {
      return;
    }
    final updated = await _trackingRepository.updateTrackingRecord(
      trackingSummaryId: trackingSummary.id,
      trackingRecordId: trackingRecord.id,
      data: data,
    );
    if (updated == null) {
      return;
    }
    Map<String, TrackingGroup> updatedTrackingGroups = {
      ...state.trackingGroups
    };
    TrackingGroup updatedTrackingGroup =
        updatedTrackingGroups[trackingSummary.section]!;

    TrackingSummary updatedTrackingSummary = updatedTrackingGroup.data
        .where((summary) => summary.id == trackingSummary.id)
        .toList()[0];

    List<TrackingRecord> updatedTrackingRecords = trackingSummary.records
        .where((record) => record.id != trackingRecord.id)
        .toList()
      ..add(TrackingRecord.fromJson(updated.toJson()))
      ..sort((a, b) => a.date.isBefore(b.date) ? -1 : 1);

    updatedTrackingSummary =
        updatedTrackingSummary.copyWith(records: updatedTrackingRecords);

    List<TrackingSummary> updatedTrackingSummaries = updatedTrackingGroup.data
        .where((summary) => summary.id != trackingSummary.id)
        .toList()
      ..add(updatedTrackingSummary);
    updatedTrackingGroups.update(
        trackingSummary.section,
        (trackingGroup) =>
            trackingGroup.copyWith(data: [...updatedTrackingSummaries]));
    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
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

  Future<void> toggleReorder() async {
    emit(state.copyWith(reorderable: !state.reorderable));
  }

  Future<void> transitionUI() async {
    emit(state.copyWith(status: TrackingStatus.transitioning));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TrackingStatus.success));
  }

  @override
  TrackingState fromJson(Map<String, dynamic> json) =>
      TrackingState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TrackingState state) => state.toJson();
}
