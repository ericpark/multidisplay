// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'tracking_cubit.dart';

/// TRACKING SETTINGS
///
/// Specifically for the settings of the tracking page on the settings page.
extension TrackingCubitSettings on TrackingCubit {
  /// Toggles the ability to reorder sections
  Future<void> toggleReorder() async {
    emit(state.copyWith(reorderable: !state.reorderable));
  }

  /// Toggles the ability to show private sections
  Future<void> toggleShowOnlyPublic() async {
    emit(state.copyWith(showOnlyPublic: !state.showOnlyPublic));
  }

  /// Moves the selected item at [oldIndex] to [newIndex]
  ///
  /// This should only happen when [reorderable] is enabled
  Future<void> reorderSections({
    required int oldIndex,
    required int newIndex,
  }) async {
    if (oldIndex == newIndex) return;

    List<String> newOrder = getNewSectionOrder(
      previousOrder: state.trackingSections,
      newIndex: newIndex,
      oldIndex: oldIndex,
    );

    emit(state.copyWith(
      status: TrackingStatus.success,
      trackingSections: newOrder,
    ));
  }
}
