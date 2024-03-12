// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_details.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<CalendarDetails> calendarDetailsCollection(
    [String path = 'calendars']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<CalendarDetails>(
          fromFirestore: (snapshot, _) =>
              CalendarDetails.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<CalendarDetails> calendarDetailsDoc(
    {String path = 'calendars', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<CalendarDetails>(
          fromFirestore: (snapshot, _) =>
              CalendarDetails.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
