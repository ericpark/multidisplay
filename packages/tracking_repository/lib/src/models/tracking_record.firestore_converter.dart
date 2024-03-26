// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_record.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<TrackingRecord> trackingRecordCollection(
    [String path = 'records']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<TrackingRecord>(
          fromFirestore: (snapshot, _) =>
              TrackingRecord.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<TrackingRecord> trackingRecordDoc(
    {String path = 'records', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<TrackingRecord>(
          fromFirestore: (snapshot, _) =>
              TrackingRecord.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
