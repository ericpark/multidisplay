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
        );
        return val;
      },
    );

Map<String, dynamic> _$CalendarStateToJson(CalendarState instance) =>
    <String, dynamic>{
      'status': _$CalendarStatusEnumMap[instance.status]!,
    };

const _$CalendarStatusEnumMap = {
  CalendarStatus.initial: 'initial',
  CalendarStatus.loading: 'loading',
  CalendarStatus.success: 'success',
  CalendarStatus.failure: 'failure',
};
