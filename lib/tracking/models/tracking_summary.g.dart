// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingSummaryImpl _$$TrackingSummaryImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingSummaryImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingSummaryImpl(
          name: $checkedConvert('name', (v) => v as String),
          section: $checkedConvert('section', (v) => v as String),
          count: $checkedConvert('count', (v) => v as int? ?? 0),
          subtitle: $checkedConvert('subtitle', (v) => v as String?),
          left: $checkedConvert('left', (v) => v as String? ?? ''),
          right: $checkedConvert('right', (v) => v as String? ?? ''),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$TrackingSummaryImplToJson(
        _$TrackingSummaryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'section': instance.section,
      'count': instance.count,
      'subtitle': instance.subtitle,
      'left': instance.left,
      'right': instance.right,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
    };
