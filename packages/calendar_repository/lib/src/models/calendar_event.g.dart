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
          endDate: $checkedConvert('end_date',
              (v) => const DateTimeConverter().fromJson(v as String)),
          eventName: $checkedConvert('event_name', (v) => v as String),
          calendarId: $checkedConvert('calendar_id', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          color: $checkedConvert(
              'color',
              (v) => _$JsonConverterFromJson<String, Color>(
                  v, const ColorConverter().fromJson)),
          allDay: $checkedConvert('all_day', (v) => v as bool?),
          active: $checkedConvert('active', (v) => v as bool?),
          createdAt: $checkedConvert('created_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          id: $checkedConvert('id', (v) => v as String?),
          recurring: $checkedConvert('recurring', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'startDate': 'start_date',
        'endDate': 'end_date',
        'eventName': 'event_name',
        'calendarId': 'calendar_id',
        'allDay': 'all_day',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'start_date': const DateTimeConverter().toJson(instance.startDate),
      'end_date': const DateTimeConverter().toJson(instance.endDate),
      'event_name': instance.eventName,
      'calendar_id': instance.calendarId,
      'description': instance.description,
      'color': const ColorConverter().toJson(instance.color),
      'all_day': instance.allDay,
      'active': instance.active,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'recurring': instance.recurring,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
