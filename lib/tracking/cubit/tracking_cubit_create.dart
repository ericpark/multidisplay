// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'tracking_cubit.dart';

/// CREATE TRACKING PAGE -----------------------------------------------------
///
/// Specifically for the new tracker page
extension TrackingCubitCreate on TrackingCubit {
  /// Add a new Tracking Summary to repository and emit updated changes
  Future<void> addNewTrackingSummary({
    required TrackingSummary trackingSummaryData,
  }) async {
    TrackingSummary createdSummary = await addNewTrackingSummaryInRepository(
      trackingSummaryData: trackingSummaryData,
    );

    // Add the new tracking summary to the tracking group
    Map<String, TrackingGroup> updatedTrackingGroups =
        addTrackingSummaryToTrackingGroups(
      trackingSummary: createdSummary,
      trackingGroups: state.trackingGroups,
    );
    // Update the state with the new tracking summary
    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }
}
