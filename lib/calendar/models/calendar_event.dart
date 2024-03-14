import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:calendar_repository/calendar_repository.dart'
    as calendar_repository;

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent extends Equatable {
  const CalendarEvent({
    required this.eventName,
    required this.start,
    required this.background,
    required this.calendarId,
    DateTime? end,
    bool? isAllDay,
    bool? active,
    String? description,
    String? notes,
  })  : end = end ?? start,
        isAllDay = isAllDay ?? true,
        active = active ?? true,
        description = description ?? "",
        notes = notes ?? "";

  CalendarEvent.empty()
      : this(
          eventName: "",
          start: DateTime(1970),
          background: Colors.transparent,
          calendarId: "",
        );

  final String eventName;
  final DateTime start;
  final DateTime end;
  final String calendarId;
  @ColorConverter()
  final Color background;
  final bool isAllDay;
  final bool active;
  final String description;
  final String notes;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  factory CalendarEvent.fromRepository(
      calendar_repository.CalendarEvent event) {
    return CalendarEvent(
      eventName: event.eventName,
      start: event.startDate,
      end: event.endDate,
      background: event.color,
      isAllDay: event.allDay,
      active: event.active,
      description: event.description,
      calendarId: event.calendarId,
    );
  }

  calendar_repository.CalendarEvent toRepository() {
    return calendar_repository.CalendarEvent(
      eventName: eventName,
      startDate: start,
      endDate: end,
      calendarId: calendarId,
      active: active,
      color: background,
      recurring: false,
      description: description,
    );
  }

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  CalendarEvent copyWith({
    String? eventName,
    DateTime? start,
    DateTime? end,
    Color? background,
    bool? isAllDay,
    bool? active,
    String? description,
    String? calendarId,
  }) {
    return CalendarEvent(
      eventName: eventName ?? this.eventName,
      start: start ?? this.start,
      end: end ?? this.end,
      background: background ?? this.background,
      isAllDay: isAllDay ?? this.isAllDay,
      active: isAllDay ?? this.active,
      description: description ?? this.description,
      calendarId: calendarId ?? this.calendarId,
    );
  }

  @override
  List<Object> get props =>
      [eventName, start, end, background, isAllDay, description, calendarId];
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  @override
  Color fromJson(String json) => Color(_getColorFromHex(json));

  @override
  String toJson(Color object) =>
      object.toString().split("(")[1].substring(4, 10);
}

class CalendarEventDataSource extends CalendarDataSource {
  CalendarEventDataSource(List<CalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
