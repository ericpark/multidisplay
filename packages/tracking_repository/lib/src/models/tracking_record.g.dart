// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingRecordImpl _$$TrackingRecordImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingRecordImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingRecordImpl(
          date: $checkedConvert(
              'date', (v) => const DateTimeConverter().fromJson(v)),
          id: $checkedConvert('id', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$TrackingRecordImplToJson(
        _$TrackingRecordImpl instance) =>
    <String, dynamic>{
      'date': const DateTimeConverter().toJson(instance.date),
      'id': instance.id,
      'description': instance.description,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
    };
