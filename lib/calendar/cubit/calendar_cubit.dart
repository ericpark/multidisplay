import 'package:bloc/bloc.dart';
import 'package:calendar_repository/calendar_repository.dart'
    show CalendarRepository;
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:multidisplay/calendar/calendar.dart';

part 'calendar_state.dart';
part 'generated/calendar_cubit.g.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._calendarRepository) : super(CalendarInitial());
  final CalendarRepository _calendarRepository;

  Future<void> init() async {
    emit(state.copyWith(status: CalendarStatus.loading));

    await getCalendarsList();
    await getCalendarDetails();
    await fetchEvents(calendarIDs: state.calendars);
  }

  Future<void> getCalendarsList() async {
    // Commented out this emit so it doesn't change from loading to
    // success to loading
    // emit(state.copyWith(status: CalendarStatus.loading));
    final calendars =
        await _calendarRepository.getAllCalendars(userId: 'default');

    emit(state.copyWith(calendars: calendars));
  }

  Future<void> getCalendarDetails() async {
    // Commented out this emit so it doesn't change from loading to
    // success to loading
    // emit(state.copyWith(status: CalendarStatus.loading));

    final calendarDetailsFromFirebase = await _calendarRepository
        .getAllCalendarDetails(calendarIDs: state.calendars);

    final calendarDetails = <String, CalendarDetails>{};

    for (final cDetails in calendarDetailsFromFirebase) {
      calendarDetails[cDetails.id!] =
          CalendarDetails.fromJson(cDetails.toJson());
    }

    emit(state.copyWith(calendarDetails: calendarDetails));
  }

  Future<void> refreshCalendar() async {
    await getCalendarDetails();

    await fetchEvents(calendarIDs: state.calendars);
    return;
  }

  Future<void> refreshCalendarUI() async {
    //emit(state.copyWith(status: CalendarStatus.loading));
    // Temporary fix to refresh after popover is gone rather than rewriting
    // the builder functions for both scheduler and month views.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: CalendarStatus.success));
  }

  Future<void> startLoading() async {
    emit(state.copyWith(status: CalendarStatus.loading));
  }

  Future<void> addCalendarEvent(CalendarEvent event) async {
    final eventData = event.toRepository();
    emit(state.copyWith(status: CalendarStatus.loading));
    final newEvent =
        await _calendarRepository.addNewEvent(eventData: eventData);

    final updatedListOfEvents = state.events
      ..add(CalendarEvent.fromRepository(newEvent));

    emit(
      state.copyWith(
        status: CalendarStatus.success,
        events: updatedListOfEvents,
      ),
    );
  }

  Future<void> updateCalendarEvent({
    required String eventId,
    required CalendarEvent event,
  }) async {
    final originalEvent =
        state.events.where((e) => e.id == eventId).toList()[0].copyWith(
              eventName: event.eventName,
              end: event.end,
              start: event.start,
              description: event.description,
              calendarId: event.calendarId,
            );

    emit(state.copyWith(status: CalendarStatus.loading));
    await _calendarRepository.updateEvent(
      eventId: eventId,
      updatedFields: originalEvent.toRepository().toJson(),
    );

    final updatedListOfEvents = state.events
        .where((event) => event.id != eventId)
        .toList()
      ..add(originalEvent);

    emit(
      state.copyWith(
        status: CalendarStatus.success,
        events: updatedListOfEvents,
      ),
    );
  }

  Future<void> fetchEvents({List<String>? calendarIDs}) async {
    calendarIDs ??= state.calendars;
    if (calendarIDs.isEmpty) return;
    emit(state.copyWith(status: CalendarStatus.loading));
    try {
      var calendarEvents = <CalendarEvent>[];
      final firebaseEvents = await _calendarRepository
          .getAllEventsFromCalendars(calendarIDs: calendarIDs);
      calendarEvents = firebaseEvents
          .map(
            (fEvent) => CalendarEvent.fromRepository(fEvent).copyWith(
              background: state.calendarDetails[fEvent.calendarId]?.color ??
                  fEvent.color,
            ),
          )
          .toList();
      emit(
        state.copyWith(
          status: CalendarStatus.success,
          events: calendarEvents,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: CalendarStatus.failure));
    }
  }

  Future<void> focusOnDate(DateTime date) async {
    emit(state.copyWith(status: CalendarStatus.transitioning));
    // Delay for transition
    await Future<void>.delayed(const Duration(milliseconds: 100));
    emit(state.copyWith(status: CalendarStatus.success, selectedDate: date));
  }

  Future<void> toggleCalendarView({CalendarView? view}) async {
    if (view != null) {
      emit(state.copyWith(view: view));
    } else {
      if (state.view == CalendarView.month) {
        emit(state.copyWith(view: CalendarView.schedule));
      }
      if (state.view == CalendarView.schedule) {
        emit(state.copyWith(view: CalendarView.month));
      }
    }
  }
}
