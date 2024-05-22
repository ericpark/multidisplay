// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

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

  /// Toggles the ability to show hidden tracking widgets
  ///
  /// This differs from [TrackingState.showOnlyPublic] because
  /// [TrackingState.showOnlyPublic] is based on the owner Id.
  Future<void> toggleShowAll() async {
    emit(state.copyWith(status: TrackingStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 200)).then((_) {
      emit(
        state.copyWith(
          status: TrackingStatus.success,
          showAll: !state.showAll,
        ),
      );
    });
  }

  /// Moves the selected item at [oldIndex] to [newIndex]
  ///
  /// This should only happen when [TrackingCubit.state.reorderable] is enabled
  Future<void> reorderSections({
    required int oldIndex,
    required int newIndex,
  }) async {
    if (oldIndex == newIndex) return;

    final newOrder = getNewSectionOrder(
      previousOrder: state.trackingSections,
      newIndex: newIndex,
      oldIndex: oldIndex,
    );

    emit(
      state.copyWith(
        status: TrackingStatus.success,
        trackingSections: newOrder,
      ),
    );
  }
}
