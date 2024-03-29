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
  DateTime get date =>
      throw _privateConstructorUsedError; //required String name,
  String? get id =>
      throw _privateConstructorUsedError; //@Default('') String location,
  String? get description =>
      throw _privateConstructorUsedError; //@Default(0) int count,
//@Default(true) bool? active,
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

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
      String? id,
      String? description,
      @DateTimeNullableConverter() DateTime? createdAt});
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
    Object? id = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      String? id,
      String? description,
      @DateTimeNullableConverter() DateTime? createdAt});
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
    Object? id = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$TrackingRecordImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingRecordImpl implements _TrackingRecord {
  _$TrackingRecordImpl(
      {@DateTimeConverter() required this.date,
      this.id,
      this.description,
      @DateTimeNullableConverter() this.createdAt});

  factory _$TrackingRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingRecordImplFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime date;
//required String name,
  @override
  final String? id;
//@Default('') String location,
  @override
  final String? description;
//@Default(0) int count,
//@Default(true) bool? active,
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TrackingRecord(date: $date, id: $id, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingRecordImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, id, description, createdAt);

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

abstract class _TrackingRecord implements TrackingRecord {
  factory _TrackingRecord(
          {@DateTimeConverter() required final DateTime date,
          final String? id,
          final String? description,
          @DateTimeNullableConverter() final DateTime? createdAt}) =
      _$TrackingRecordImpl;

  factory _TrackingRecord.fromJson(Map<String, dynamic> json) =
      _$TrackingRecordImpl.fromJson;

  @override
  @DateTimeConverter()
  DateTime get date;
  @override //required String name,
  String? get id;
  @override //@Default('') String location,
  String? get description;
  @override //@Default(0) int count,
//@Default(true) bool? active,
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TrackingRecordImplCopyWith<_$TrackingRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
