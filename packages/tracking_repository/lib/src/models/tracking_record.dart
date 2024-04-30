import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/tracking_record.g.dart';
part 'generated/tracking_record.firestore_converter.dart';
part 'generated/tracking_record.freezed.dart';

@freezed
@FirestoreConverter(defaultPath: 'records')
class TrackingRecord with _$TrackingRecord {
  factory TrackingRecord({
    @DateTimeConverter() required DateTime date,
    //required String name,
    String? id,
    //@Default('') String location,
    String? description,
    //@Default(0) int count,
    //@Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    //String? id,
    //@Default([]) List<String>? tags,
  }) = _TrackingRecord;

  factory TrackingRecord.fromJson(Map<String, dynamic> json) =>
      _$TrackingRecordFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  Timestamp toJson(DateTime timestamp) => Timestamp.fromDate(timestamp);
}

class DateTimeNullableConverter implements JsonConverter<DateTime?, dynamic> {
  const DateTimeNullableConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

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
