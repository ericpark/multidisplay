import 'dart:async';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarRepository {
  CalendarRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseDB;

  //
  // This should be moved into User Repository later.
  //
  Future<List<String>> getAllCalendars({required String userId}) async {
    if (userId.length == 0) {
      return [];
    } else {
      final userRef = _firebaseDB.collection("users").doc(userId);

      List<String> calendars = [];
      try {
        calendars = await userRef.get().then(
          (querySnapshot) {
            final user = querySnapshot.data();
            // if the user is null, return empty array, then cast
            return (user?["calendars"] ?? []).cast<String>();
          },
          onError: (e) => print("Error completing: $e"),
        );
        return calendars;
      } catch (err) {
        print("Error while retrieving calendar events: $err");
        return [];
      }
    }
  }

  Future<List<CalendarDetails>> getAllCalendarDetails({
    required List<String> calendarIDs,
  }) async {
    if (calendarIDs.length == 0) {
      return [];
    } else {
      final calendarDetailsRef = calendarDetailsCollection("calendars");
      final query = calendarDetailsRef
          .where("active", isEqualTo: true)
          .where("id", whereIn: calendarIDs);
      List<CalendarDetails> allCalendarDetails = [];
      try {
        allCalendarDetails = await query.get().then(
          (querySnapshot) {
            List<CalendarDetails> calDetails = [];
            for (var docSnapshot in querySnapshot.docs) {
              calDetails.add(docSnapshot.data());
            }
            return calDetails;
          },
          onError: (e) => print("Error completing: $e"),
        );
        return allCalendarDetails;
      } catch (err) {
        print("Error while retrieving calendar details: $err");
        return [];
      }
    }
  }

  Future<List<CalendarEvent>> getAllEventsFromCalendars({
    required List<String> calendarIDs,
  }) async {
    if (calendarIDs.length == 0) {
      return [];
    } else {
      final eventsRef = calendarEventCollection("events");
      final query = eventsRef
          .where("active", isEqualTo: true)
          .where("calendar_id", whereIn: calendarIDs);
      List<CalendarEvent> allEvents = [];
      try {
        allEvents = await query.get().then(
          (querySnapshot) {
            List<CalendarEvent> events = [];
            for (var docSnapshot in querySnapshot.docs) {
              events.add(docSnapshot.data());
            }
            return events;
          },
          onError: (e) => print("Error completing: $e"),
        );
        return allEvents;
      } catch (err) {
        print("Error while retrieving calendar events: $err");
        return [];
      }
    }
  }

  //
  // CRUD functions
  //

  // CREATE Event
  Future<CalendarEvent> addNewEvent({
    required CalendarEvent eventData,
  }) async {
    final eventsRef = calendarEventCollection("events");
    final eventId = await eventsRef
        .add(eventData)
        .then((documentSnapshot) => documentSnapshot.id);
    updateEvent(eventId: eventId, updatedFields: {"id": eventId});
    return eventData.copyWith(id: eventId);
  }

  // READ Event
  Future<CalendarEvent?> getEvent({
    required String eventId,
  }) async {
    final eventRef = calendarEventDoc(docId: eventId);

    final eventData = await eventRef.get().then((snapshot) => snapshot.data());
    return eventData;
  }

  // UPDATE Event
  Future<void> updateEvent({
    required String eventId,
    required Map<String, dynamic> updatedFields,
  }) async {
    final eventRef = calendarEventDoc(docId: eventId);
    updatedFields['updatedAt'] = FieldValue.serverTimestamp();

    await eventRef.update(updatedFields);
  }
}
