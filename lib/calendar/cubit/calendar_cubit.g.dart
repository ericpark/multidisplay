// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

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
          calendarDetails: $checkedConvert(
              'calendar_details',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(
                        k, CalendarDetails.fromJson(e as Map<String, dynamic>)),
                  ) ??
                  const {}),
          events: $checkedConvert(
              'events',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
                  .toList()),
          selectedDate: $checkedConvert('selected_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'calendarDetails': 'calendar_details',
        'selectedDate': 'selected_date'
      },
    );

Map<String, dynamic> _$CalendarStateToJson(CalendarState instance) =>
    <String, dynamic>{
      'status': _$CalendarStatusEnumMap[instance.status]!,
      'calendars': instance.calendars,
      'calendar_details':
          instance.calendarDetails.map((k, e) => MapEntry(k, e.toJson())),
      'events': instance.events.map((e) => e.toJson()).toList(),
      'selected_date': instance.selectedDate.toIso8601String(),
    };

const _$CalendarStatusEnumMap = {
  CalendarStatus.initial: 'initial',
  CalendarStatus.loading: 'loading',
  CalendarStatus.success: 'success',
  CalendarStatus.failure: 'failure',
};
