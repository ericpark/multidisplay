import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:multidisplay/calendar/calendar.dart';

import 'package:calendar_repository/calendar_repository.dart'
    show CalendarRepository;

part 'calendar_state.dart';

part 'calendar_cubit.g.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._calendarRepository) : super(CalendarInitial());
  final CalendarRepository _calendarRepository;

  Future<void> refreshCalendar() async {
    return;
  }

  Future<void> addCalendarEvent() async {
    return;
  }

  Future<void> updateCalendarEvent() async {
    return;
  }

  Future<void> fetchEvents(String? calendarID) async {
    if (calendarID == null || calendarID.isEmpty) return;

    emit(state.copyWith(status: CalendarStatus.loading));

    try {
      List<Meeting> calendarEvents = getEvents();
      final test =
          await _calendarRepository.getAllEvents(calendarID: "guestcal");

      calendarEvents.insert(
          0,
          Meeting(test[0].eventName, test[0].startDate, test[0].endDate,
              Color.fromARGB(255, 134, 72, 15), false));
      emit(state.copyWith(
          status: CalendarStatus.success, events: calendarEvents));
    } on Exception {
      emit(state.copyWith(status: CalendarStatus.failure));
    }
  }

  List<Meeting> getEvents() {
    final List<Meeting> meetings = <Meeting>[];
    //final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(2023, 11, 3, 13, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 2));
    meetings.add(Meeting(
        'Ke Mary Otis', startTime, endTime, const Color(0xFF0F8644), false));
    final DateTime startTime2 = DateTime(2024, 2, 13, 13, 0, 0);
    final DateTime endTime2 = startTime2.add(const Duration(days: 10));
    meetings.add(
        Meeting('Milo', startTime2, endTime2, const Color(0xFF0F8644), false));
    return meetings;
  }

  @override
  CalendarState fromJson(Map<String, dynamic> json) =>
      CalendarState.fromJson(json);

  /*@override
  Map<String, dynamic> toJson(CalendarState state) => state.toJson();*/
}
