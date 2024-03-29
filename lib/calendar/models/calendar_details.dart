import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/calendar/calendar.dart';

part 'calendar_details.g.dart';
part 'calendar_details.freezed.dart';

@freezed
//@JsonSerializable(explicitToJson: true)
class CalendarDetails with _$CalendarDetails {
  factory CalendarDetails({
    String? id,
    required String ownerId,
    required String name,
    @Default('') String description,
    @Default([]) List<String>? users,
    @ColorConverter() @Default(Colors.transparent) Color color,
    @Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    @Default([]) List<String>? tags,
  }) = _CalendarDetails;

  factory CalendarDetails.fromJson(Map<String, dynamic> json) =>
      _$CalendarDetailsFromJson(json);
}

class DateTimeNullableConverter implements JsonConverter<DateTime?, dynamic> {
  const DateTimeNullableConverter();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp?.toDate() ?? DateTime.now();

  @override
  Timestamp toJson(DateTime? timestamp) =>
      Timestamp.fromDate(timestamp ?? DateTime.now());
}
