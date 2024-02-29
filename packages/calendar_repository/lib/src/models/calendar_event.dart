import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent extends Equatable {
  CalendarEvent({
    required this.startDate,
    required this.endDate,
    required this.eventName,
    String? description,
  }) : description = description ?? '';

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @DateTimeConverter()
  final DateTime startDate;
  final DateTime endDate;
  final String eventName;
  final String description;

  @override
  List<Object> get props => [startDate, endDate, eventName, description];

  factory CalendarEvent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Map data = doc.data() as Map<String, dynamic>;

    return CalendarEvent(
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      eventName: data['eventName'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'eventName': eventName,
      'description': description,
    };
  }

  CalendarEvent mapToCalendarEvent(Map<String, dynamic> event) {
    return CalendarEvent(
      startDate: event['startDate'],
      endDate: event["endDate"],
      eventName: event['eventName'] ?? '',
      description: event['description'] ?? '',
    );
  }
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
}
