// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_summary.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<TrackingSummary> trackingSummaryCollection(
    [String path = 'tracking']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<TrackingSummary>(
          fromFirestore: (snapshot, _) =>
              TrackingSummary.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<TrackingSummary> trackingSummaryDoc(
    {String path = 'tracking', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<TrackingSummary>(
          fromFirestore: (snapshot, _) =>
              TrackingSummary.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
