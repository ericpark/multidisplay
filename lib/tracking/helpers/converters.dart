import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
}

class DateTimeNullableConverter implements JsonConverter<DateTime?, dynamic> {
  const DateTimeNullableConverter();

  @override
  DateTime fromJson(dynamic timestamp) =>
      timestamp != null ? DateTime.parse(timestamp) : DateTime.now();

  @override
  String toJson(DateTime? object) =>
      DateFormat("yyyy-MM-dd").format(object ?? DateTime.now());
}
