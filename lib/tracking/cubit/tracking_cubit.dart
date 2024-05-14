import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:multidisplay/app/helpers/helpers.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:tracking_repository/tracking_repository.dart'
    show TrackingRepository;

part 'generated/tracking_cubit.freezed.dart';
part 'generated/tracking_cubit.g.dart';
part 'tracking_state.dart';
part 'tracking_cubit_ui.dart';
part 'tracking_cubit_helpers.dart';
part 'tracking_cubit_settings.dart';
part 'tracking_cubit_create.dart';
part 'tracking_cubit_details.dart';
part 'tracking_cubit_widgets.dart';

/// TrackingCubit handles the business logic needed by the Tracking Page and
/// widgets.
///
/// This class should be as clean as possible and only contain high level
/// business logic. Some methods are included here to help with the UI and
/// transitions. All methods here should emit a new state at the end of the
/// function (except those that need the mixins).
class TrackingCubit extends HydratedCubit<TrackingState>
    with
        TimeTrackingCubit<TrackingState>,
        ConsecutiveTrackingCubit<TrackingState>,
        LastSevenTrackingCubit<TrackingState>,
        DaysSinceTrackingCubit<TrackingState>,
        FixedWeekTrackingCubit<TrackingState> {
  TrackingCubit(this._trackingRepository)
      : super(
          const TrackingState(),
        );

  final TrackingRepository _trackingRepository;

  /// Initialize tracking data on page load.
  ///
  /// This should only be called on initial cubit load or when the a user logs in/out.
  Future<void> init({String? userId}) async {
    emit(state.copyWith(status: TrackingStatus.loading));

    // Get Tracking Groups and Data
    final groups = await getTrackingGroups(
      userId: userId,
      showOnlyPublic: state.showOnlyPublic,
    );

    // Get Tracking Groups for each section.
    // [forceUpdate] = true will update all metrics.
    final updatedTrackingGroups = await _getUpdatedTrackingGroups(
      trackingGroups: groups,
      forceUpdate: true,
    );

    emit(
      state.copyWith(
        status: TrackingStatus.success,
        trackingSections: groups.keys.toList(),
        trackingGroups: updatedTrackingGroups,
      ),
    );
  }

  /// UPDATING METRICS  --------------------------------------------------------

  Future<Map<String, TrackingGroup>> _getUpdatedTrackingGroups({
    required Map<String, TrackingGroup> trackingGroups,
    bool checkDayUpdate = false,
    bool forceUpdate = false,
  }) async {
    final groups = <String, TrackingGroup>{};
    // Get sections from repository
    final sections = trackingGroups.keys.toList();

    for (final sectionName in sections) {
      final trackingGroup = trackingGroups[sectionName]!;
      if (trackingGroup.data.isNotEmpty) {
        final updatedTrackingGroup = trackingGroup.copyWith(
          data: await _getUpdatedTrackingSummaries(
            trackingSummaries: trackingGroup.data,
            checkDayUpdate: checkDayUpdate,
            forceUpdate: forceUpdate,
          ),
        );
        groups[sectionName] = updatedTrackingGroup;
      }
    }

    return groups;
  }

  /// Update Tracking Summary Metrics based on conditions to return updated List
  /// Checks [TrackingSummary.autoUpdate] to see if the metric should be updated
  /// [checkDayUpdate] set to true will consider fetchedAt date
  /// [forceUpdate] set to true will ensure all metrics are updated
  /// This will update any changes in the repository
  Future<List<TrackingSummary>> _getUpdatedTrackingSummaries({
    required List<TrackingSummary> trackingSummaries,
    bool checkDayUpdate = false,
    bool forceUpdate = false,
  }) async {
    if (trackingSummaries.isEmpty) return [];

    final updatedTrackingSummaries = <TrackingSummary>[];

    for (final trackingSummary in trackingSummaries) {
      // trackingSummary is added here because it may or may not be updated.
      updatedTrackingSummaries.add(trackingSummary);

      /// TRACKING GROUPS
      /// Skip if metrics shouldn't be autoUpdated and shouldn't be forceUpdated
      /// if [forceUpdate] or [autoUpdate] is true, this will not continue
      /// Skips the updating TrackingSummary if both are false
      if (!trackingSummary.autoUpdate && !forceUpdate) continue;

      // if fetchedAt is missing or it's not today, return false
      /*final fetchedToday = trackingSummary.fetchedAt != null
          ? trackingSummary.fetchedAt!.isToday
          : false;*/
      final fetchedToday = trackingSummary.fetchedAt?.isToday ?? false;

      /// Skip if not checking new day or already fetched today
      /// if [forceUpdate] is true or [checkDayUpdate] is false, this will stop
      /// Skips the updating TrackingSummary if checkDayUpdate is true,
      /// and fetchedToday is true and forceUpdate is false
      if (checkDayUpdate && fetchedToday && !forceUpdate) continue;

      // There was no reason to skip so the tracking summary is updated
      final updatedTrackingSummary =
          await _updateTrackingSummaryMetrics(trackingSummary: trackingSummary);

      /// The updatedTrackingSummary should always be the most up to date.
      /// Update the last element in the list with the updatedTrackingSummary.
      /// It is done this way because the list copies over the summary and then
      /// updates if needed.
      updatedTrackingSummaries[updatedTrackingSummaries.length - 1] =
          updatedTrackingSummary;

      // If the metrics were updated, update it in repository
      final metricsUpdated = !(const DeepCollectionEquality()
          .equals(updatedTrackingSummary.metrics, trackingSummary.metrics));

      if (metricsUpdated) {
        // Does not need to wait for saves to the repository
        await _trackingRepository.updateTrackingSummary(
          trackingSummaryId: updatedTrackingSummary.id,
          data: updatedTrackingSummary.toRepository().toJson(),
        );
      }
    }

    return updatedTrackingSummaries;
  }

  /// Calculates and updates the tracking summary metrics based on the
  /// tracking type
  Future<TrackingSummary> _updateTrackingSummaryMetrics({
    required TrackingSummary trackingSummary,
  }) async {
    TrackingSummary updatedTrackingSummary;

    // Get all records for the tracking summary and convert to app model
    // TODO(ericpark): This should be more efficient based on the tracking type.
    final records =
        (await _trackingRepository.getTrackingRecordsForTrackingSummary(
      trackingSummaryId: trackingSummary.id,
    ))
            .map((rec) => TrackingRecord.fromJson(rec.toJson()))
            .toList();

    // There are no records so nothing to update.
    if (records.isEmpty) return trackingSummary;

    switch (trackingSummary.trackingType) {
      case 'consecutive':
        updatedTrackingSummary = incrementConsecutiveTracker(
          trackingSummary: trackingSummary.copyWith(records: records),
        );
      case 'last_seven':
        updatedTrackingSummary = incrementLastSevenTracker(
          trackingSummary: trackingSummary.copyWith(records: records),
        );
      case 'days_ago':
        updatedTrackingSummary = incrementDaysSince(
          trackingSummary: trackingSummary.copyWith(records: records),
        );
      case 'fixed_week':
        updatedTrackingSummary = decrementFixedWeekTracker(
          trackingSummary: trackingSummary.copyWith(records: records),
        );
      case 'time':
        updatedTrackingSummary = calculateTimeBasedTracker(
          trackingSummary: trackingSummary.copyWith(records: records),
        );
      default:
        updatedTrackingSummary = trackingSummary.copyWith(records: records);
    }

    return updatedTrackingSummary;
  }

  /// HYDRATED CUBIT OVERRIDES -------------------------------------------------
  @override
  TrackingState fromJson(Map<String, dynamic> json) =>
      TrackingState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TrackingState state) => state.toJson();

  /// --------------------------------------------------------------------------
}
