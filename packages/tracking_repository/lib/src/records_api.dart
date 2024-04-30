part of 'tracking_repository.dart';

mixin RecordsAPI {
  /** 
   * Tracking Record CRUD
   */

  /** CREATE */

  Future<TrackingRecord?> addTrackingRecordsForTrackingSummary({
    required String trackingSummaryId,
    required TrackingRecord trackingData,
  }) async {
    if (trackingSummaryId == "") {
      return null;
    } else {
      final trackingRecordsCollectionRef =
          trackingRecordCollection("tracking/$trackingSummaryId/records");

      final trackingRecordId = await trackingRecordsCollectionRef
          .add(trackingData)
          .then((documentSnapshot) => documentSnapshot.id);
      updateTrackingRecord(
          trackingSummaryId: trackingSummaryId,
          trackingRecordId: trackingRecordId,
          data: {"id": trackingRecordId});
      return trackingData.copyWith(id: trackingRecordId);
    }
  }

  /** READ */

  ///
  Future<List<TrackingRecord>> getTrackingRecordsForTrackingSummary(
      {required String trackingSummaryId}) async {
    if (trackingSummaryId == "") {
      return [];
    } else {
      final trackingRecordsCollectionRef =
          trackingRecordCollection("tracking/$trackingSummaryId/records");
      final query =
          trackingRecordsCollectionRef.orderBy("date", descending: false);
      //.where("active", isEqualTo: true)
      //.where("section", isEqualTo: section);
      List<TrackingRecord> allTrackingRecords = [];
      try {
        allTrackingRecords = await query.get().then(
          (querySnapshot) {
            List<TrackingRecord> trackingRecords = [];

            for (var docSnapshot in querySnapshot.docs) {
              TrackingRecord data = docSnapshot.data();
              if (data.id == null || data.id == "") {
                // If ID is empty, update it in firebase
                updateTrackingRecord(
                    trackingSummaryId: trackingSummaryId,
                    trackingRecordId: docSnapshot.id,
                    data: {"id": docSnapshot.id});
                data = data.copyWith(id: docSnapshot.id);
              }

              trackingRecords.add(data);
            }
            return trackingRecords;
          },
          onError: (e) => print("Error completing: $e"),
        );
        return allTrackingRecords;
      } catch (err) {
        print("Error while retrieving tracking records: $err");
        return [];
      }
    }
  }

  /** UPDATE */

  Future<TrackingRecord?> updateTrackingRecord({
    required String trackingSummaryId,
    required String trackingRecordId,
    required data,
  }) async {
    if (trackingSummaryId == "") {
      return null;
    }
    if (trackingRecordId == "") {
      return null;
    } else {
      final trackingRecRef = trackingRecordDoc(
          path: "tracking/$trackingSummaryId/records", docId: trackingRecordId);

      final query = trackingRecRef;
      try {
        return await query.update(data).then(
          (_) async {
            final trackingRecord = await query.get().then((doc) {
              return doc.data();
            });
            return trackingRecord;
          },
          onError: (e) => print("Error completing: $e"),
        );
      } catch (err) {
        print("Error while retrieving tracking summaries: $err");
        return null;
      }
    }
  }

  /** DELETE */

  Future<String> deleteTrackingRecord({
    required String trackingSummaryId,
    required String trackingRecordId,
  }) async {
    if (trackingSummaryId == "") {
      return "Missing Tracking Summary Id";
    }
    if (trackingRecordId == "") {
      return "Missing Tracking Record Id";
    } else {
      final trackingRecRef = trackingRecordDoc(
          path: "tracking/$trackingSummaryId/records", docId: trackingRecordId);

      final query = trackingRecRef;
      try {
        return await query.delete().then(
          (querySnapshot) {
            return "Successfully deleted";
          },
          onError: (e) => print("Error completing: $e"),
        );
      } catch (err) {
        print("Error while retrieving tracking summaries: $err");
        return "Error: $err";
      }
    }
  }
}
