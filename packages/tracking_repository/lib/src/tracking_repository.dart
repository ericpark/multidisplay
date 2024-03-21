import 'dart:async';

import 'package:tracking_repository/tracking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackingRepository {
  TrackingRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  // ignore: unused_field
  final FirebaseFirestore _firebaseDB;

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
      final trackingRef = trackingSummaryCollection();
      final query = trackingRef
          .where("active", isEqualTo: true)
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
                /*updateTrackingSummary(
                    trackingSummaryId: docSnapshot.id,
                    data: {"id": docSnapshot.id});*/
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
      return trackingData.copyWith(id: trackingRecordId);
    }
  }
}
