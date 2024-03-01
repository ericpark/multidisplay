// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarEventImpl _$$CalendarEventImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CalendarEventImpl',
      json,
      ($checkedConvert) {
        final val = _$CalendarEventImpl(
          startDate: $checkedConvert(
              'start_date', (v) => const DateTimeConverter().fromJson(v)),
          endDate: $checkedConvert(
              'end_date', (v) => const DateTimeConverter().fromJson(v)),
          eventName: $checkedConvert('event_name', (v) => v as String),
          calendarId: $checkedConvert('calendar_id', (v) => v as String),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          color: $checkedConvert(
              'color',
              (v) => v == null
                  ? Colors.transparent
                  : const ColorConverter().fromJson(v as String)),
          allDay: $checkedConvert('all_day', (v) => v as bool? ?? true),
          active: $checkedConvert('active', (v) => v as bool? ?? true),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
          id: $checkedConvert('id', (v) => v as String?),
          recurring: $checkedConvert('recurring', (v) => v as bool? ?? false),
          tags: $checkedConvert(
              'tags',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
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

Map<String, dynamic> _$$CalendarEventImplToJson(_$CalendarEventImpl instance) =>
    <String, dynamic>{
      'start_date': const DateTimeConverter().toJson(instance.startDate),
      'end_date': const DateTimeConverter().toJson(instance.endDate),
      'event_name': instance.eventName,
      'calendar_id': instance.calendarId,
      'description': instance.description,
      'color': const ColorConverter().toJson(instance.color),
      'all_day': instance.allDay,
      'active': instance.active,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'id': instance.id,
      'recurring': instance.recurring,
      'tags': instance.tags,
    };
