import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/app/helpers/helpers.dart';
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
part 'tracking_cubit_tracking_group.dart';

class TrackingCubit extends HydratedCubit<TrackingState> {
  TrackingCubit(this._trackingRepository)
      : super(const TrackingState(
            status: TrackingStatus.initial, trackingGroups: {}));

  final TrackingRepository _trackingRepository;

  /// Initialize tracking data on page load. This should only be called on
  /// initial cubit load or when the a user logs in/out.
  Future<void> init({String? userId}) async {
    emit(state.copyWith(status: TrackingStatus.loading));

    // Get Tracking Groups and Data
    Map<String, TrackingGroup> groups =
        await fetchTrackingGroups(userId: userId);

    emit(state.copyWith(
      status: TrackingStatus.success,
      trackingSections: groups.keys.toList(),
      trackingGroups: groups,
    ));
  }

  /**
   * Tracking Group
   */

  /// Return Tracking Group and all data
  Future<Map<String, TrackingGroup>> fetchTrackingGroups(
      {String? userId}) async {
    Map<String, TrackingGroup> groups = {};
    // Get sections from repository
    List<String> sections = (await _trackingRepository.getAllTrackingGroups())
        .map((trackingGroup) => trackingGroup.name)
        .toList();

    for (var sectionName in sections) {
      TrackingGroup data = await getTrackingDataForSection(
          userId: (state.showOnlyPublic ? "default" : userId) ?? "default",
          section: sectionName);
      if (data.data.isNotEmpty) {
        groups[sectionName] = data;
      }
    }

    return groups;
  }

  Future<TrackingGroup> getTrackingDataForSection(
      {required String userId, required String section}) async {
    List<TrackingSummary> trackingSummaries = [];

    // Get List<_trackingRepository.TrackingSummary> from repository
    final repoSummaries =
        await _trackingRepository.getTrackingSummariesByOwnerIdForSection(
            userId: userId, section: section);

    // convert from repository model to app model using app model's fromRepository
    trackingSummaries = repoSummaries
        .map((summary) => TrackingSummary.fromRepository(summary))
        .toList();

    // get the updated tracking summaries
    final updatedTrackingSummaries =
        await getUpdatedTrackingSummaries(trackingSummaries: trackingSummaries);

    return TrackingGroup(name: section, data: updatedTrackingSummaries);
  }

  /**
   * Tracking Summary
   */

  /// Update Tracking Summary Metrics based on conditions and return updated List
  /// Checks [autoUpdate] to see if the metric should be updated
  /// [checkDayUpdate] set to true will consider fetchedAt date
  /// [forceUpdate] set to true will ensure all metrics are updated
  /// This will update any changes in the repository
  Future<List<TrackingSummary>> getUpdatedTrackingSummaries({
    required List<TrackingSummary> trackingSummaries,
    bool checkDayUpdate = false,
    bool forceUpdate = false,
  }) async {
    if (trackingSummaries.isEmpty) {
      return [];
    }

    List<TrackingSummary> updatedTrackingSummaries = [];

    for (TrackingSummary trackingSummary in trackingSummaries) {
      //TrackingSummary trackingSummary = trackingSummaries[index];
      updatedTrackingSummaries.add(trackingSummary);

      // Skip if it shouldn't be autoUpdated and shouldn't be forceUpdated
      // if [forceUpdate] or [autoUpdate] is true, this will not continue
      // Skips the updating TrackingSummary if both are false
      if (!trackingSummary.autoUpdate && !forceUpdate) {
        continue;
      }
      // if fetchedAt is missing or it's not today, return false
      bool fetchedToday = trackingSummary.fetchedAt != null
          ? trackingSummary.fetchedAt!.isToday
          : false;

      // Skip if not checking new day or already fetched today
      // if [forceUpdate] is true or [checkDayUpdate] is false, this will not continue
      // Skips the updating TrackingSummary if checkDayUpdate is true,
      // and fetchedToday is true and forceUpdate is false
      if (checkDayUpdate && fetchedToday && !forceUpdate) {
        continue;
      }
      // There was no reason to skip so the tracking summary is updated
      TrackingSummary updatedTrackingSummary =
          await updateTrackingSummaryMetrics(trackingSummary: trackingSummary);

      // The updatedTrackingSummary should always be the most up to date.
      updatedTrackingSummaries[updatedTrackingSummaries.length - 1] =
          updatedTrackingSummary;

      // If the metrics were updated, update it in repository
      bool metricsUpdated = !(const DeepCollectionEquality()
          .equals(updatedTrackingSummary.metrics, trackingSummary.metrics));
      if (metricsUpdated) {
        // Does not need to wait for saves to the repository
        _trackingRepository.updateTrackingSummary(
            trackingSummaryId: updatedTrackingSummary.id,
            data: updatedTrackingSummary.toRepository().toJson());
      }
    }

    return updatedTrackingSummaries;
  }

  ///
  TrackingSummary indexToTrackingSummary(
      {required String section, required int index}) {
    TrackingGroup trackingGroup = state.trackingGroups[section]!;
    return trackingGroup.data[index];
  }

  /** 
  * Tracking Record
  */

  ///
  Future<TrackingRecord> addTrackingRecord(
      {required String trackingSummaryId, DateTime? date}) async {
    final newRecord = TrackingRecord(date: date ?? DateTime.now());
    final trackingData = newRecord.toRepository();
    final createdRecord =
        await _trackingRepository.addTrackingRecordsForTrackingSummary(
            trackingSummaryId: trackingSummaryId, trackingData: trackingData);
    return createdRecord != null
        ? TrackingRecord.fromJson(createdRecord.toJson())
        : newRecord;
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
      ..sort((a, b) => a.date.midnight.isBefore(b.date.midnight) ? -1 : 1);

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

  Future<void> refreshTrackingSummariesOnNewDay() async {
    Map<String, TrackingGroup> updatedTrackingGroups = {
      ...state.trackingGroups
    };

    for (int index = 0; index < state.trackingSections.length; index++) {
      var section = state.trackingSections[index];
      List<TrackingSummary> trackingSummaries =
          (state.trackingGroups[section]?.data ?? []);
      List<TrackingSummary> updatedTrackingSummaries =
          await getUpdatedTrackingSummaries(
              trackingSummaries: trackingSummaries, checkDayUpdate: true);

      updatedTrackingGroups.update(
          section,
          (trackingGroup) =>
              trackingGroup.copyWith(data: updatedTrackingSummaries));
    }

    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }

  /**
   * Tracking Widgets
   */

  ///
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

  /** 
  * UI helpers
  */

  /// Refresh all Tracking Groups and data
  Future<void> refreshTrackingGroups({String? userId}) async {
    emit(state.copyWith(status: TrackingStatus.loading));

    Map<String, TrackingGroup> groups =
        await fetchTrackingGroups(userId: userId);

    emit(state.copyWith(
      status: TrackingStatus.success,
      trackingGroups: groups,
      trackingSections: groups.keys.toList(),
    ));
  }

  /// Toggles the ability to reorder sections
  Future<void> toggleReorder() async {
    emit(state.copyWith(
      reorderable: !state.reorderable,
    ));
  }

  Future<void> toggleShowOnlyPublic() async {
    emit(state.copyWith(
      showOnlyPublic: !state.showOnlyPublic,
    ));
  }

  /// Moves the selected item at [oldIndex] to [newIndex]
  /// This should only happen when [reorderable] is enabled
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
    // unknown error
    else {
      emit(state.copyWith(status: TrackingStatus.failure));
      return;
    }
    emit(state.copyWith(
      status: TrackingStatus.success,
      trackingSections: newOrder,
    ));
  }

  /// Helper function to wait for transitions
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
