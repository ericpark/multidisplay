// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_group.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<TrackingGroup> trackingGroupCollection(
    [String path = 'tracking_groups']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<TrackingGroup>(
          fromFirestore: (snapshot, _) =>
              TrackingGroup.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<TrackingGroup> trackingGroupDoc(
    {String path = 'tracking_groups', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<TrackingGroup>(
          fromFirestore: (snapshot, _) =>
              TrackingGroup.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
