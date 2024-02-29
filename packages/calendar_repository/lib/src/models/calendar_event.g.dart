// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CalendarEvent',
      json,
      ($checkedConvert) {
        final val = CalendarEvent(
          startDate: $checkedConvert('start_date',
              (v) => const DateTimeConverter().fromJson(v as String)),
          endDate:
              $checkedConvert('end_date', (v) => DateTime.parse(v as String)),
          eventName: $checkedConvert('event_name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'startDate': 'start_date',
        'endDate': 'end_date',
        'eventName': 'event_name'
      },
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'start_date': const DateTimeConverter().toJson(instance.startDate),
      'end_date': instance.endDate.toIso8601String(),
      'event_name': instance.eventName,
      'description': instance.description,
    };
