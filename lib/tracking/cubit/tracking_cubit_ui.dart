// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'tracking_cubit.dart';

extension TrackingCubitUIHelpers on TrackingCubit {
  /// Refresh all Tracking Groups and data on New Day
  Future<void> refreshTrackingSummariesOnNewDay({String? userId}) async {
    // Get Tracking Groups and Data
    Map<String, TrackingGroup> groups = await getTrackingGroups(
      userId: userId,
      showOnlyPublic: state.showOnlyPublic,
    );
    // Update Tracking Groups and Data
    Map<String, TrackingGroup> updatedTrackingGroups =
        await _getUpdatedTrackingGroups(
      trackingGroups: groups,
      forceUpdate: true,
    );

    emit(state.copyWith(
        status: TrackingStatus.success, trackingGroups: updatedTrackingGroups));
  }

  /// Refresh all Tracking Groups and data
  Future<void> refreshTrackingGroups({String? userId}) async {
    emit(state.copyWith(status: TrackingStatus.loading));

    Map<String, TrackingGroup> groups = await getTrackingGroups(
      userId: userId,
      showOnlyPublic: state.showOnlyPublic,
    );

    // Update Tracking Groups and Data
    Map<String, TrackingGroup> updatedTrackingGroups =
        await _getUpdatedTrackingGroups(
      trackingGroups: groups,
      forceUpdate: true,
    );

    emit(state.copyWith(
      status: TrackingStatus.success,
      trackingGroups: updatedTrackingGroups,
      trackingSections: groups.keys.toList(),
    ));
  }

  /// Helper function to wait for transitions
  Future<void> transitionUI() async {
    emit(state.copyWith(status: TrackingStatus.transitioning));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TrackingStatus.success));
  }
}
