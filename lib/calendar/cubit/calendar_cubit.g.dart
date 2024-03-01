// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarState _$CalendarStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CalendarState',
      json,
      ($checkedConvert) {
        final val = CalendarState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$CalendarStatusEnumMap, v) ??
                  CalendarStatus.initial),
          calendars: $checkedConvert(
              'calendars',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          events: $checkedConvert(
              'events',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$CalendarStateToJson(CalendarState instance) =>
    <String, dynamic>{
      'status': _$CalendarStatusEnumMap[instance.status]!,
      'calendars': instance.calendars,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };

const _$CalendarStatusEnumMap = {
  CalendarStatus.initial: 'initial',
  CalendarStatus.loading: 'loading',
  CalendarStatus.success: 'success',
  CalendarStatus.failure: 'failure',
};
