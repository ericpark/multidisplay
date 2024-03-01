import 'dart:async';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarRepository {
  CalendarRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseDB;

  Future<List<CalendarEvent>> getAllEventsFromCalendars(
      {required List<String> calendarIDs}) async {
    if (calendarIDs.length == 0) {
      return [];
    } else {
      final eventsRef = calendarEventCollection("events");
      /*final eventsRef = _firebaseDB.collection("events").withConverter(
            fromFirestore: CalendarEvent.fromFirestore,
            toFirestore: (CalendarEvent event, _) => event.toFirestore(),
          );*/

      final query = eventsRef
          //.where("active", isEqualTo: true)
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

  Future<CalendarEvent> addNewEvent({required CalendarEvent eventData}) async {
    final eventsRef = calendarEventCollection("events");

    /*final eventsRef = _firebaseDB.collection("events").withConverter(
          fromFirestore: CalendarEvent.fromFirestore,
          toFirestore: (CalendarEvent calEvent, options) =>
              calEvent.toFirestore(),
        );*/

    final eventId = await eventsRef
        .add(eventData)
        .then((documentSnapshot) => documentSnapshot.id);

    return eventData.copyWith(id: eventId);
  }
/*
  Future<void> updateEvent({required CalendarEvent eventData} );
    final eventRef = _firebaseDB.collection("events").withConverter(
          fromFirestore: CalendarEvent.fromFirestore,
          toFirestore: (CalendarEvent calEvent, options) =>
              calEvent.toFirestore(),
        );

    await eventRef.add(event).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }*/
}
