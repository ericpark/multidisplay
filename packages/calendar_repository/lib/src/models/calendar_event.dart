import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:equatable/equatable.dart';

//import 'package:json_annotation/json_annotation.dart';
import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.g.dart';
part 'calendar_event.firestore_converter.dart';
part 'calendar_event.freezed.dart';

@freezed
//@JsonSerializable(explicitToJson: true)
@FirestoreConverter(defaultPath: 'events')
class CalendarEvent with _$CalendarEvent {
  factory CalendarEvent({
    @DateTimeConverter() required DateTime startDate,
    @DateTimeConverter() required DateTime endDate,
    required String eventName,
    required String calendarId,
    @Default('') String description,
    @ColorConverter() @Default(Colors.transparent) Color color,
    @Default(true) bool? allDay,
    @Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    String? id,
    @Default(false) bool? recurring,
    @Default([]) List<String>? tags,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime timestamp) => Timestamp.fromDate(timestamp);
}

class DateTimeNullableConverter implements JsonConverter<DateTime?, dynamic> {
  const DateTimeNullableConverter();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp?.toDate() ?? DateTime.now();

  @override
  Timestamp toJson(DateTime? timestamp) =>
      Timestamp.fromDate(timestamp ?? DateTime.now());
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
      object.toString().split("(")[1].substring(4, 10); //Hexcode
}
