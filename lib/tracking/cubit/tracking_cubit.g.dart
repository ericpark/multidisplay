// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingStateImpl _$$TrackingStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingStateImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingStateImpl(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$TrackingStatusEnumMap, v) ??
                  TrackingStatus.initial),
          trackingGroups: $checkedConvert(
              'tracking_groups',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(
                        k, TrackingGroup.fromJson(e as Map<String, dynamic>)),
                  ) ??
                  const {}),
          trackingSections: $checkedConvert(
              'tracking_sections',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {
        'trackingGroups': 'tracking_groups',
        'trackingSections': 'tracking_sections'
      },
    );

Map<String, dynamic> _$$TrackingStateImplToJson(_$TrackingStateImpl instance) =>
    <String, dynamic>{
      'status': _$TrackingStatusEnumMap[instance.status]!,
      'tracking_groups':
          instance.trackingGroups.map((k, e) => MapEntry(k, e.toJson())),
      'tracking_sections': instance.trackingSections,
    };

const _$TrackingStatusEnumMap = {
  TrackingStatus.initial: 'initial',
  TrackingStatus.loading: 'loading',
  TrackingStatus.transitioning: 'transitioning',
  TrackingStatus.success: 'success',
  TrackingStatus.failure: 'failure',
};
