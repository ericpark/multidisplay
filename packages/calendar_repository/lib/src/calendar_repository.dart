import 'dart:async';

import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarRepository {
  CalendarRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseDB;

  Future<List<CalendarEvent>> getAllEvents({required String calendarID}) async {
    if (calendarID == "") {
      return [];
    } else {
      final eventsRef = _firebaseDB.collection("events").withConverter(
            fromFirestore: CalendarEvent.fromFirestore,
            toFirestore: (CalendarEvent event, _) => event.toFirestore(),
          );
      ;
      final query = eventsRef
          //.where("active", isEqualTo: true)
          .where("calendarID", isEqualTo: calendarID);
      List<CalendarEvent> allEvents = [];
      try {
        allEvents = await query.get().then(
          (querySnapshot) {
            List<CalendarEvent> events = [];
            for (var docSnapshot in querySnapshot.docs) {
              events.add(docSnapshot.data() as CalendarEvent);
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
}
