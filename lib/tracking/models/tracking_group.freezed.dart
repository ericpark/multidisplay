// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingGroup _$TrackingGroupFromJson(Map<String, dynamic> json) {
  return _TrackingGroup.fromJson(json);
}

/// @nodoc
mixin _$TrackingGroup {
//@DateTimeConverter() required DateTime date,
  String get name => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<TrackingSummary> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingGroupCopyWith<TrackingGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingGroupCopyWith<$Res> {
  factory $TrackingGroupCopyWith(
          TrackingGroup value, $Res Function(TrackingGroup) then) =
      _$TrackingGroupCopyWithImpl<$Res, TrackingGroup>;
  @useResult
  $Res call(
      {String name,
      String notes,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<TrackingSummary> data});
}

/// @nodoc
class _$TrackingGroupCopyWithImpl<$Res, $Val extends TrackingGroup>
    implements $TrackingGroupCopyWith<$Res> {
  _$TrackingGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TrackingSummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingGroupImplCopyWith<$Res>
    implements $TrackingGroupCopyWith<$Res> {
  factory _$$TrackingGroupImplCopyWith(
          _$TrackingGroupImpl value, $Res Function(_$TrackingGroupImpl) then) =
      __$$TrackingGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String notes,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<TrackingSummary> data});
}

/// @nodoc
class __$$TrackingGroupImplCopyWithImpl<$Res>
    extends _$TrackingGroupCopyWithImpl<$Res, _$TrackingGroupImpl>
    implements _$$TrackingGroupImplCopyWith<$Res> {
  __$$TrackingGroupImplCopyWithImpl(
      _$TrackingGroupImpl _value, $Res Function(_$TrackingGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? notes = null,
    Object? createdAt = freezed,
    Object? data = null,
  }) {
    return _then(_$TrackingGroupImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TrackingSummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingGroupImpl implements _TrackingGroup {
  _$TrackingGroupImpl(
      {required this.name,
      this.notes = '',
      @DateTimeNullableConverter() this.createdAt,
      final List<TrackingSummary> data = const []})
      : _data = data;

  factory _$TrackingGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingGroupImplFromJson(json);

//@DateTimeConverter() required DateTime date,
  @override
  final String name;
  @override
  @JsonKey()
  final String notes;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  final List<TrackingSummary> _data;
  @override
  @JsonKey()
  List<TrackingSummary> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'TrackingGroup(name: $name, notes: $notes, createdAt: $createdAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingGroupImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, notes, createdAt,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingGroupImplCopyWith<_$TrackingGroupImpl> get copyWith =>
      __$$TrackingGroupImplCopyWithImpl<_$TrackingGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingGroupImplToJson(
      this,
    );
  }
}

abstract class _TrackingGroup implements TrackingGroup {
  factory _TrackingGroup(
      {required final String name,
      final String notes,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final List<TrackingSummary> data}) = _$TrackingGroupImpl;

  factory _TrackingGroup.fromJson(Map<String, dynamic> json) =
      _$TrackingGroupImpl.fromJson;

  @override //@DateTimeConverter() required DateTime date,
  String get name;
  @override
  String get notes;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  List<TrackingSummary> get data;
  @override
  @JsonKey(ignore: true)
  _$$TrackingGroupImplCopyWith<_$TrackingGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
