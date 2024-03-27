// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingRecord _$TrackingRecordFromJson(Map<String, dynamic> json) {
  return _TrackingRecord.fromJson(json);
}

/// @nodoc
mixin _$TrackingRecord {
  @DateTimeConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingRecordCopyWith<TrackingRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingRecordCopyWith<$Res> {
  factory $TrackingRecordCopyWith(
          TrackingRecord value, $Res Function(TrackingRecord) then) =
      _$TrackingRecordCopyWithImpl<$Res, TrackingRecord>;
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime date,
      String id,
      @DateTimeNullableConverter() DateTime? createdAt,
      String? description});
}

/// @nodoc
class _$TrackingRecordCopyWithImpl<$Res, $Val extends TrackingRecord>
    implements $TrackingRecordCopyWith<$Res> {
  _$TrackingRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? id = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingRecordImplCopyWith<$Res>
    implements $TrackingRecordCopyWith<$Res> {
  factory _$$TrackingRecordImplCopyWith(_$TrackingRecordImpl value,
          $Res Function(_$TrackingRecordImpl) then) =
      __$$TrackingRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime date,
      String id,
      @DateTimeNullableConverter() DateTime? createdAt,
      String? description});
}

/// @nodoc
class __$$TrackingRecordImplCopyWithImpl<$Res>
    extends _$TrackingRecordCopyWithImpl<$Res, _$TrackingRecordImpl>
    implements _$$TrackingRecordImplCopyWith<$Res> {
  __$$TrackingRecordImplCopyWithImpl(
      _$TrackingRecordImpl _value, $Res Function(_$TrackingRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? id = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_$TrackingRecordImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingRecordImpl extends _TrackingRecord {
  _$TrackingRecordImpl(
      {@DateTimeConverter() required this.date,
      this.id = '',
      @DateTimeNullableConverter() this.createdAt,
      this.description})
      : super._();

  factory _$TrackingRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingRecordImplFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime date;
  @override
  @JsonKey()
  final String id;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  @override
  final String? description;

  @override
  String toString() {
    return 'TrackingRecord(date: $date, id: $id, createdAt: $createdAt, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingRecordImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, id, createdAt, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingRecordImplCopyWith<_$TrackingRecordImpl> get copyWith =>
      __$$TrackingRecordImplCopyWithImpl<_$TrackingRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingRecordImplToJson(
      this,
    );
  }
}

abstract class _TrackingRecord extends TrackingRecord {
  factory _TrackingRecord(
      {@DateTimeConverter() required final DateTime date,
      final String id,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final String? description}) = _$TrackingRecordImpl;
  _TrackingRecord._() : super._();

  factory _TrackingRecord.fromJson(Map<String, dynamic> json) =
      _$TrackingRecordImpl.fromJson;

  @override
  @DateTimeConverter()
  DateTime get date;
  @override
  String get id;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TrackingRecordImplCopyWith<_$TrackingRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
