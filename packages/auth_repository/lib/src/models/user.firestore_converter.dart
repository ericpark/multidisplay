// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<User> userCollection([String path = 'users']) {
  return FirebaseFirestore.instance.collection(path).withConverter<User>(
      fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
      toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<User> userDoc(
    {String path = 'users', required String docId}) {
  return FirebaseFirestore.instance.doc('$path/$docId').withConverter<User>(
      fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
      toFirestore: (instance, _) => instance.toJson());
}
