// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockEventReference extends Mock
    implements CollectionReference<CalendarEvent> {}

class MockCalendarEvent extends Mock implements CalendarEvent {}

void main() {
  group('CalendarRepository', () {
    late FirebaseFirestore firebaseDB;
    late CalendarRepository calendarRepository;

    setUp(() async {
      await Firebase.initializeApp();
      firebaseDB = FirebaseFirestore.instance;
      calendarRepository = CalendarRepository(firebaseDB: firebaseDB);
    });

    group('getAllEvents', () {
      const calendarID = 'guestcal';

      /*test('calls getAllEvents with correct CalendarID', () async {
        final calendarEvent = MockCalendarEvent();
        when(() => calendarEvent.startDate).thenReturn(DateTime(2024, 2, 13));
        when(() => calendarEvent.startDate).thenReturn(DateTime(2024, 2, 22));
        when(() => calendarEvent.description).thenReturn(
            "Watching Milo while Sabrina and Wayne are in Singapore.");
        when(() => calendarEvent.eventName).thenReturn("Milo Dog Sitting");
        when(() => firebaseDB
            .collection(any())
            .where(any())
            .get(any())
            .then(any())).thenAnswer(
          (_) async => calendarEvent,
        );
        try {
          await calendarRepository.getAllEvents(calendarID: calendarID);
        } catch (_) {}
        verify(
          () => calendarRepository.getAllEvents(
            calendarID: calendarID,
          ),
        ).called(1);
      });*/

      test('returns correct CalendarEvent on success', () async {
        final calendarEvent = MockCalendarEvent();
        final mockCollectionReference = MockCollectionReference();
        final mockEventReference = MockEventReference();
        when(() => calendarEvent.startDate).thenReturn(DateTime(2024, 2, 13));
        when(() => calendarEvent.startDate).thenReturn(DateTime(2024, 2, 22));
        when(() => calendarEvent.description).thenReturn(
            "Watching Milo while Sabrina and Wayne are in Singapore.");
        when(() => calendarEvent.eventName).thenReturn("Milo Dog Sitting");

        final Query<CalendarEvent> result =
            firebaseDB.collection("events").withConverter(
                  fromFirestore: CalendarEvent.fromFirestore,
                  toFirestore: (CalendarEvent event, _) => event.toFirestore(),
                );

        expect(result, isA<Query<CalendarEvent>>());

        when(() => firebaseDB.collection("events"))
            .thenAnswer((_) => mockCollectionReference);
        when(() => mockCollectionReference.withConverter(
              fromFirestore: CalendarEvent.fromFirestore,
              toFirestore: (CalendarEvent event, _) => event.toFirestore(),
            )).thenAnswer((_) => mockEventReference);
        when(() => calendarRepository.getAllEvents(calendarID: calendarID))
            .thenAnswer((_) async => [calendarEvent]);

        final actual =
            await calendarRepository.getAllEvents(calendarID: calendarID);
        expect(
          actual,
          [
            CalendarEvent(
              startDate: DateTime(2024, 2, 13),
              endDate: DateTime(2024, 2, 22),
              eventName: 'Milo Dog Sitting',
              description:
                  'Watching Milo while Sabrina and Wayne are in Singapore.',
            ),
          ],
        );
      });
    });
  });
}
