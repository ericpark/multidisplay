// GENERATED CODE - DO NOT MODIFY BY HAND

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
          end: $checkedConvert('end', (v) => DateTime.parse(v as String)),
          background: $checkedConvert('background',
              (v) => const ColorConverter().fromJson(v as String)),
          isAllDay: $checkedConvert('is_all_day', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'eventName': 'event_name', 'isAllDay': 'is_all_day'},
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) =>
    <String, dynamic>{
      'event_name': instance.eventName,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'background': const ColorConverter().toJson(instance.background),
      'is_all_day': instance.isAllDay,
    };
