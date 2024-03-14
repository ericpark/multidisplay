// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingEventImpl _$$TrackingEventImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingEventImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingEventImpl(
          date: $checkedConvert(
              'date', (v) => const DateTimeConverter().fromJson(v)),
          name: $checkedConvert('name', (v) => v as String),
          trackingId: $checkedConvert('tracking_id', (v) => v as String),
          location: $checkedConvert('location', (v) => v as String? ?? ''),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          count: $checkedConvert('count', (v) => v as int? ?? 0),
          active: $checkedConvert('active', (v) => v as bool? ?? true),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
          id: $checkedConvert('id', (v) => v as String?),
          tags: $checkedConvert(
              'tags',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {
        'trackingId': 'tracking_id',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$$TrackingEventImplToJson(_$TrackingEventImpl instance) =>
    <String, dynamic>{
      'date': const DateTimeConverter().toJson(instance.date),
      'name': instance.name,
      'tracking_id': instance.trackingId,
      'location': instance.location,
      'description': instance.description,
      'count': instance.count,
      'active': instance.active,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'id': instance.id,
      'tags': instance.tags,
    };
