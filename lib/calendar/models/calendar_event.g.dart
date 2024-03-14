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
          eventName: $checkedConvert('event_name', (v) => v as String),
          start: $checkedConvert('start', (v) => DateTime.parse(v as String)),
          background: $checkedConvert('background',
              (v) => const ColorConverter().fromJson(v as String)),
          calendarId: $checkedConvert('calendar_id', (v) => v as String),
          end: $checkedConvert(
              'end', (v) => v == null ? null : DateTime.parse(v as String)),
          isAllDay: $checkedConvert('is_all_day', (v) => v as bool?),
          active: $checkedConvert('active', (v) => v as bool?),
          description: $checkedConvert('description', (v) => v as String?),
          notes: $checkedConvert('notes', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventName': 'event_name',
        'calendarId': 'calendar_id',
        'isAllDay': 'is_all_day'
      },
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'event_name': instance.eventName,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'calendar_id': instance.calendarId,
      'background': const ColorConverter().toJson(instance.background),
      'is_all_day': instance.isAllDay,
      'active': instance.active,
      'description': instance.description,
      'notes': instance.notes,
    };
