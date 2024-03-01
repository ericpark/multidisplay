import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'calendar_event.g.dart';

@JsonSerializable(explicitToJson: true)
class CalendarEvent extends Equatable {
  CalendarEvent(
      {required this.startDate,
      required this.endDate,
      required this.eventName,
      required this.calendarId,
      String? description,
      Color? color,
      bool? allDay,
      bool? active,
      DateTime? createdAt,
      String? id,
      bool? recurring})
      : description = description ?? '',
        color = color ?? Colors.transparent,
        allDay = allDay ?? true,
        active = active ?? true,
        createdAt = createdAt ?? DateTime.now(),
        id = id ?? '',
        recurring = recurring ?? false;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @DateTimeConverter()
  final DateTime startDate;
  @DateTimeConverter()
  final DateTime endDate;
  final String eventName;
  final String calendarId;
  final String description;
  @ColorConverter()
  final Color color;
  final bool allDay;
  final bool active;
  final DateTime createdAt;
  final String id;
  final bool recurring;

  @override
  List<Object> get props => [
        startDate,
        endDate,
        eventName,
        calendarId,
        description,
        color,
        allDay,
        active,
        createdAt,
        id,
        recurring
      ];

  factory CalendarEvent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Map data = doc.data() as Map<String, dynamic>;

    return CalendarEvent(
        startDate: (data['startDate'] as Timestamp).toDate(),
        endDate: (data['endDate'] as Timestamp).toDate(),
        eventName: data['eventName'],
        calendarId: data['calendarID'],
        description: data['description'] ?? '',
        color:
            Color(ColorConverter._getColorFromHex(data['color'] ?? "#ffffff")),
        allDay: data['allDay'],
        active: data['active'],
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        id: data['id'],
        recurring: data['recurring']);
  }

  // Copy toJSON() and make changes as needed
  Map<String, dynamic> toFirestore() {
    return {
      'start_date': Timestamp.fromDate(this.startDate),
      'end_date': Timestamp.fromDate(this.endDate),
      'event_name': this.eventName,
      'calendar_id': this.calendarId,
      'description': this.description,
      'color': const ColorConverter().toJson(this.color),
      'all_day': this.allDay,
      'active': this.active,
      'created_at': Timestamp.fromDate(this.createdAt),
      'id': this.id,
      'recurring': this.recurring,
    };
  }
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
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
