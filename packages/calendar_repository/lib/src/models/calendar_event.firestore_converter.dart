// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// FirestoreConverterGenerator
// **************************************************************************

CollectionReference<CalendarEvent> calendarEventCollection(
    [String path = 'events']) {
  return FirebaseFirestore.instance
      .collection(path)
      .withConverter<CalendarEvent>(
          fromFirestore: (snapshot, _) =>
              CalendarEvent.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}

DocumentReference<CalendarEvent> calendarEventDoc(
    {String path = 'events', required String docId}) {
  return FirebaseFirestore.instance
      .doc('$path/$docId')
      .withConverter<CalendarEvent>(
          fromFirestore: (snapshot, _) =>
              CalendarEvent.fromJson(snapshot.data()!),
          toFirestore: (instance, _) => instance.toJson());
}
