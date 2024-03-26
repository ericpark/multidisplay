import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

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
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
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
  String toJson(DateTime? object) =>
      DateFormat("yyyy-MM-dd").format(object ?? DateTime.now());
}
