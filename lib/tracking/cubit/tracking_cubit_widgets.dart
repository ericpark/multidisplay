// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

part of 'tracking_cubit.dart';

/// TRACKING WIDGETS METHODS
///
/// Specifically for handling actions from the tracking page widgets.
extension TrackingCubitWidgets on TrackingCubit {
  /// Add Tracking Record and update Tracking Summary
  ///
  ///
  Future<void> addTrackingRecordAndUpdateSummary({
    required String section,
    required int index,
  }) async {
    final trackingSummary = indexToTrackingSummary(
      section: section,
      index: index,
      trackingGroups: state.trackingGroups,
    );

    if (trackingSummary.id == '') return;

    await addTrackingRecordFromRepository(
      trackingSummaryId: trackingSummary.id,
    );

    final updatedTrackingSummary =
        await _updateTrackingSummaryMetrics(trackingSummary: trackingSummary);

    final updatedTrackingGroups = await updateTrackingSummaryInRepository(
      section: section,
      index: index,
      trackingGroups: state.trackingGroups,
      updatedTrackingSummary: updatedTrackingSummary,
    );

    emit(
      state.copyWith(
        status: TrackingStatus.success,
        trackingGroups: updatedTrackingGroups,
      ),
    );
  }

  /// Update Time Tracking End Time
  ///
  ///
  Future<void> recordFinishTime({
    required String section,
    required int index,
  }) async {
    final trackingSummary = indexToTrackingSummary(
      section: section,
      index: index,
      trackingGroups: state.trackingGroups,
    );

    if (trackingSummary.id == '') return;

    final description = 'Finished at ${DateTime.now()}';

    await updateTrackingRecordInRepository(
      trackingSummary: trackingSummary,
      trackingRecord:
          trackingSummary.records.last.copyWith(description: description),
      trackingGroups: state.trackingGroups,
      data: {'description': description},
    );

    final updatedTrackingSummary =
        await _updateTrackingSummaryMetrics(trackingSummary: trackingSummary);

    final updatedTrackingGroups = await updateTrackingSummaryInRepository(
      section: section,
      index: index,
      trackingGroups: state.trackingGroups,
      updatedTrackingSummary: updatedTrackingSummary,
    );

    emit(
      state.copyWith(
        status: TrackingStatus.success,
        trackingGroups: updatedTrackingGroups,
      ),
    );
  }

  /// Update Tracking Summary in the UI
  Future<void> updateTrackingSummary(
    String section,
    int index,
    TrackingSummary updatedTrackingSummary,
  ) async {
    final updatedTrackingGroups = await updateTrackingSummaryInRepository(
      section: section,
      index: index,
      trackingGroups: state.trackingGroups,
      updatedTrackingSummary: updatedTrackingSummary,
    );
    emit(
      state.copyWith(
        status: TrackingStatus.success,
        trackingGroups: updatedTrackingGroups,
      ),
    );
  }

  /// Add a TrackingRecord to repository and return created TrackingRecord
  ///
  /// The createdRecord will contain the created [id] used in the repository.
  Future<TrackingRecord> addTrackingRecordFromRepository({
    required String trackingSummaryId,
    DateTime? date,
  }) async {
    final newRecord = TrackingRecord(date: date ?? DateTime.now());
    final trackingData = newRecord.toRepository();

    final createdRecord =
        await _trackingRepository.addTrackingRecordsForTrackingSummary(
      trackingSummaryId: trackingSummaryId,
      trackingData: trackingData,
    );

    return createdRecord != null
        ? TrackingRecord.fromJson(createdRecord.toJson())
        : newRecord;
  }

  Map<String, TrackingGroup> deleteTrackingRecordFromRepository({
    required String trackingSummaryId,
    required String trackingRecordId,
    required Map<String, TrackingGroup> trackingGroups,
    required String section,
  }) {
    _trackingRepository.deleteTrackingRecord(
      trackingSummaryId: trackingSummaryId,
      trackingRecordId: trackingRecordId,
    );

    final updatedTrackingGroups = <String, TrackingGroup>{...trackingGroups}
      ..update(
        section,
        (trackingGroup) => trackingGroup.copyWith(
          data: trackingGroup.data
              .where((record) => record.id != trackingRecordId)
              .toList(),
        ),
      );

    return updatedTrackingGroups;
  }

  Future<Map<String, TrackingGroup>> updateTrackingRecordInRepository({
    required TrackingSummary trackingSummary,
    required TrackingRecord trackingRecord,
    required Map<String, TrackingGroup> trackingGroups,
    required dynamic data,
  }) async {
    final updated = await _trackingRepository.updateTrackingRecord(
      trackingSummaryId: trackingSummary.id,
      trackingRecordId: trackingRecord.id,
      data: data,
    );

    if (updated == null) {
      // TODO(ericpark): HANDLE ERROR
      return trackingGroups;
    }

    final updatedTrackingGroups = <String, TrackingGroup>{...trackingGroups};
    final updatedTrackingGroup =
        updatedTrackingGroups[trackingSummary.section]!;

    var updatedTrackingSummary = updatedTrackingGroup.data
        .where((summary) => summary.id == trackingSummary.id)
        .toList()[0];

    final updatedTrackingRecords = trackingSummary.records
        .where((record) => record.id != trackingRecord.id)
        .toList()
      ..add(TrackingRecord.fromJson(updated.toJson()))
      ..sort((a, b) => a.date.midnight.isBefore(b.date.midnight) ? -1 : 1);

    updatedTrackingSummary =
        updatedTrackingSummary.copyWith(records: updatedTrackingRecords);

    final updatedTrackingSummaries = updatedTrackingGroup.data
        .where((summary) => summary.id != trackingSummary.id)
        .toList()
      ..add(updatedTrackingSummary);
    updatedTrackingGroups.update(
      trackingSummary.section,
      (trackingGroup) =>
          trackingGroup.copyWith(data: [...updatedTrackingSummaries]),
    );

    return updatedTrackingGroups;
  }

  /// -----------------------------------------------------------------------

  Future<TrackingSummary> addNewTrackingSummaryInRepository({
    required TrackingSummary trackingSummaryData,
  }) async {
    final trackingData = trackingSummaryData.toRepository();
    final createdTrackingSummary = await _trackingRepository.addTrackingSummary(
      trackingSummaryData: trackingData,
    );

    return TrackingSummary.fromRepository(createdTrackingSummary!);
  }

  Future<Map<String, TrackingGroup>> updateTrackingSummaryInRepository({
    required String section,
    required int index,
    required TrackingSummary updatedTrackingSummary,
    required Map<String, TrackingGroup> trackingGroups,
  }) async {
    final updatedTrackingGroups = <String, TrackingGroup>{...trackingGroups}
      ..update(
        section,
        (trackingGroup) => trackingGroup.copyWith(
          data: [
            ...trackingGroup.data.sublist(0, index),
            updatedTrackingSummary,
            ...trackingGroup.data.sublist(index + 1),
          ],
        ),
      );

    await _trackingRepository.updateTrackingSummary(
      trackingSummaryId: updatedTrackingSummary.id,
      data: updatedTrackingSummary.toRepository().toJson(),
    );

    return updatedTrackingGroups;
  }

  /// Add TrackingSummary to TrackingGroups and return updated tracking groups.
  Map<String, TrackingGroup> addTrackingSummaryToTrackingGroups({
    required TrackingSummary trackingSummary,
    required Map<String, TrackingGroup> trackingGroups,
  }) {
    final updatedTrackingGroups = <String, TrackingGroup>{...trackingGroups}
      ..update(
        trackingSummary.section,
        (trackingGroup) => trackingGroup
            .copyWith(data: [...trackingGroup.data, trackingSummary]),
      );

    // TODO(ericpark): Handle reorder
    // TODO(ericpark): Handle visibility
    return updatedTrackingGroups;
  }

  /// -----------------------------------------------------------------------

  /// -----------------------------------------------------------------------
  /// TRACKING GROUPS -------------------------------------------------------
  /// -----------------------------------------------------------------------

  /// Return Tracking Group and all data
  Future<Map<String, TrackingGroup>> getTrackingGroups({
    required bool showOnlyPublic,
    String? userId,
  }) async {
    final groups = <String, TrackingGroup>{};

    // Get sections from repository as is.
    final sections = (await _trackingRepository.getAllTrackingGroups())
        .map((trackingGroup) => trackingGroup.name)
        .toList();

    // Get the tracking summaries for each of the sections
    for (final sectionName in sections) {
      final data = await getTrackingDataForSection(
        userId: (showOnlyPublic ? 'default' : userId) ?? 'default',
        section: sectionName,
      );
      if (data.data.isNotEmpty) {
        groups[sectionName] = data;
      }
    }

    return groups;
  }

  Future<TrackingGroup> getTrackingDataForSection({
    required String userId,
    required String section,
  }) async {
    var trackingSummaries = <TrackingSummary>[];

    // Get List<_trackingRepository.TrackingSummary> from repository
    final repoSummaries =
        await _trackingRepository.getTrackingSummariesByOwnerIdForSection(
      userId: userId,
      section: section,
    );

    // convert from repository model to app model using
    // app model's fromRepository
    trackingSummaries =
        repoSummaries.map(TrackingSummary.fromRepository).toList();

    // get the updated tracking summaries
    /*final updatedTrackingSummaries =
        await getUpdatedTrackingSummaries(trackingSummaries: trackingSummaries);
        */

    return TrackingGroup(name: section, data: trackingSummaries);
  }

  /// --------------------------------------------------------------------------
}
