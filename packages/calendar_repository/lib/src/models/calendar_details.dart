import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:calendar_repository/calendar_repository.dart';

part 'calendar_details.g.dart';
part 'calendar_details.firestore_converter.dart';
part 'calendar_details.freezed.dart';

@freezed
//@JsonSerializable(explicitToJson: true)
@FirestoreConverter(defaultPath: 'calendars')
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
