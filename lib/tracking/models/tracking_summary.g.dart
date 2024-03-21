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
          count: $checkedConvert('total', (v) => v as int? ?? 0),
          subtitle: $checkedConvert('tracking_subtitle', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String),
          ownerId: $checkedConvert('owner_id', (v) => v as String),
          mainMetric: $checkedConvert('main_metric', (v) => v as String? ?? ''),
          leftMetric: $checkedConvert('left_metric', (v) => v as String? ?? ''),
          rightMetric:
              $checkedConvert('right_metric', (v) => v as String? ?? ''),
          metrics: $checkedConvert(
              'metrics',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
                  ) ??
                  const {}),
          autoUpdate:
              $checkedConvert('auto_update', (v) => v as bool? ?? false),
          records: $checkedConvert(
              'records',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          TrackingRecord.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          trackingType:
              $checkedConvert('tracking_type', (v) => v as String? ?? ''),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'count': 'total',
        'subtitle': 'tracking_subtitle',
        'ownerId': 'owner_id',
        'mainMetric': 'main_metric',
        'leftMetric': 'left_metric',
        'rightMetric': 'right_metric',
        'autoUpdate': 'auto_update',
        'trackingType': 'tracking_type',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$$TrackingSummaryImplToJson(
        _$TrackingSummaryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'section': instance.section,
      'total': instance.count,
      'tracking_subtitle': instance.subtitle,
      'id': instance.id,
      'owner_id': instance.ownerId,
      'main_metric': instance.mainMetric,
      'left_metric': instance.leftMetric,
      'right_metric': instance.rightMetric,
      'metrics': instance.metrics,
      'auto_update': instance.autoUpdate,
      'records': instance.records.map((e) => e.toJson()).toList(),
      'tracking_type': instance.trackingType,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
    };
