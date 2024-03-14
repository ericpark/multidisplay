import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracking_event.g.dart';
part 'tracking_event.firestore_converter.dart';
part 'tracking_event.freezed.dart';

@freezed
@FirestoreConverter(defaultPath: 'tracking')
class TrackingEvent with _$TrackingEvent {
  factory TrackingEvent({
    @DateTimeConverter() required DateTime date,
    required String name,
    required String trackingId,
    @Default('') String location,
    @Default('') String description,
    @Default(0) int count,
    @Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    String? id,
    @Default([]) List<String>? tags,
  }) = _TrackingEvent;

  factory TrackingEvent.fromJson(Map<String, dynamic> json) =>
      _$TrackingEventFromJson(json);
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
