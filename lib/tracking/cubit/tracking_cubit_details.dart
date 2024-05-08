// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'tracking_cubit.dart';

// TRACKING DETAILS
///
/// Specifically for the details page for a specific tracking summary.
extension TrackingCubitDetails on TrackingCubit {
  /// Handles Deleting a Tracking Record in the UI
  Future<void> deleteTrackingRecord({
    required String trackingSummaryId,
    required String trackingRecordId,
    required String section,
  }) async {
    if (trackingSummaryId == "") return;
    if (trackingRecordId == "") return;

    Map<String, TrackingGroup> updatedTrackingGroups =
        deleteTrackingRecordFromRepository(
      trackingSummaryId: trackingSummaryId,
      trackingRecordId: trackingRecordId,
      trackingGroups: state.trackingGroups,
      section: section,
    );

    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }

  /// Handles Updating a Tracking Record in the UI
  Future<void> updateTrackingRecord({
    required TrackingSummary trackingSummary,
    required TrackingRecord trackingRecord,
    required data,
  }) async {
    if (trackingSummary.id == "") return;
    if (trackingRecord.id == "") return;

    Map<String, TrackingGroup> updatedTrackingGroups =
        await updateTrackingRecordInRepository(
      trackingSummary: trackingSummary,
      trackingRecord: trackingRecord,
      trackingGroups: state.trackingGroups,
      data: data,
    );

    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }
}
