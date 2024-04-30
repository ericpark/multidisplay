part of 'tracking_repository.dart';

mixin SummariesAPI {
  /**
  * Tracking Summary CRUD
  */

  /** CREATE */
  ///
  Future<TrackingSummary?> addTrackingSummary({
    required TrackingSummary trackingSummaryData,
  }) async {
    final TrackingSummaryRef = trackingSummaryCollection();

    final trackingSummaryId = await TrackingSummaryRef.add(trackingSummaryData)
        .then((documentSnapshot) => documentSnapshot.id);

    updateTrackingSummary(
        trackingSummaryId: trackingSummaryId, data: {"id": trackingSummaryId});

    return trackingSummaryData.copyWith(id: trackingSummaryId);
  }

  /** READ */
  ///
  Future<List<TrackingSummary>> getAllTrackingSummariesByOwnerId(
      {required String userId}) async {
    if (userId == "") {
      return [];
    } else {
      final trackingRef = trackingSummaryCollection();
      final query = trackingRef
          .where("active", isEqualTo: true)
          .where("owner_id", isEqualTo: userId);
      List<TrackingSummary> allTrackingSummaries = [];
      try {
        allTrackingSummaries = await query.get().then(
          (querySnapshot) {
            List<TrackingSummary> trackingSummaries = [];
            for (var docSnapshot in querySnapshot.docs) {
              TrackingSummary data = docSnapshot.data();
              if (data.id == null || data.id == "") {
                print("${data.id} => ${docSnapshot.id} ");
                data = data.copyWith(id: docSnapshot.id);
              }

              trackingSummaries.add(data);
            }
            return trackingSummaries;
          },
          onError: (e) => print("Error completing: $e"),
        );
        return allTrackingSummaries;
      } catch (err) {
        print("Error while retrieving tracking summaries: $err");
        return [];
      }
    }
  }

  Future<List<TrackingSummary>> getTrackingSummariesByOwnerIdForSection(
      {required String userId, required String section}) async {
    if (section == "") {
      return [];
    } else {
      final ids = [userId, "default"];
      final trackingRef = trackingSummaryCollection();
      final query = trackingRef
          .where("active", isEqualTo: true)
          .where("owner_id", whereIn: ids)
          .where("section", isEqualTo: section);
      List<TrackingSummary> allTrackingSummaries = [];
      try {
        allTrackingSummaries = await query.get().then(
          (querySnapshot) {
            List<TrackingSummary> trackingSummaries = [];

            for (var docSnapshot in querySnapshot.docs) {
              TrackingSummary data = docSnapshot.data();
              if (data.id == null || data.id == "") {
                // If ID is empty, update it in firebase
                updateTrackingSummary(
                    trackingSummaryId: docSnapshot.id,
                    data: {"id": docSnapshot.id});
                data = data.copyWith(id: docSnapshot.id);
              }

              trackingSummaries.add(data);
            }
            return trackingSummaries;
          },
          onError: (e) => print("Error completing: $e"),
        );
        return allTrackingSummaries;
      } catch (err) {
        print("Error while retrieving tracking summaries: $err");
        return [];
      }
    }
  }

  Future<TrackingSummary?> getTrackingSummaryById({
    required String trackingSummaryId,
  }) async {
    if (trackingSummaryId == "") {
      return null;
    } else {
      final trackingRef = trackingSummaryDoc(docId: trackingSummaryId);

      TrackingSummary? trackingSummary;
      try {
        trackingSummary = await trackingRef.get().then(
          (doc) {
            return doc.data();
          },
          onError: (e) => print("Error completing: $e"),
        );
        return trackingSummary;
      } catch (err) {
        print("Error while retrieving tracking summaries: $err");
        return null;
      }
    }
  }

  /** UPDATE */

  Future<String> updateTrackingSummary(
      {required String trackingSummaryId, required data}) async {
    if (trackingSummaryId == "") {
      return "Error: No ID";
    } else {
      final trackingRef = trackingSummaryDoc(docId: trackingSummaryId);
      final query = trackingRef;
      try {
        return await query.update(data).then(
          (querySnapshot) {
            return "Successful";
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
