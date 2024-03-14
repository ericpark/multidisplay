// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_event.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<TrackingEvent> trackingEventCollection(
    [String path = 'tracking']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<TrackingEvent>(
          fromFirestore: (snapshot, _) =>
              TrackingEvent.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<TrackingEvent> trackingEventDoc(
    {String path = 'tracking', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<TrackingEvent>(
          fromFirestore: (snapshot, _) =>
              TrackingEvent.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
