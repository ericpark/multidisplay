// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingSummary _$TrackingSummaryFromJson(Map<String, dynamic> json) {
  return _TrackingSummary.fromJson(json);
}

/// @nodoc
mixin _$TrackingSummary {
  String get name => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String get left => throw _privateConstructorUsedError;
  String get right => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingSummaryCopyWith<TrackingSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingSummaryCopyWith<$Res> {
  factory $TrackingSummaryCopyWith(
          TrackingSummary value, $Res Function(TrackingSummary) then) =
      _$TrackingSummaryCopyWithImpl<$Res, TrackingSummary>;
  @useResult
  $Res call(
      {String name,
      String section,
      int count,
      String? subtitle,
      String left,
      String right,
      @DateTimeNullableConverter() DateTime? createdAt});
}

/// @nodoc
class _$TrackingSummaryCopyWithImpl<$Res, $Val extends TrackingSummary>
    implements $TrackingSummaryCopyWith<$Res> {
  _$TrackingSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? section = null,
    Object? count = null,
    Object? subtitle = freezed,
    Object? left = null,
    Object? right = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String,
      right: null == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingSummaryImplCopyWith<$Res>
    implements $TrackingSummaryCopyWith<$Res> {
  factory _$$TrackingSummaryImplCopyWith(_$TrackingSummaryImpl value,
          $Res Function(_$TrackingSummaryImpl) then) =
      __$$TrackingSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String section,
      int count,
      String? subtitle,
      String left,
      String right,
      @DateTimeNullableConverter() DateTime? createdAt});
}

/// @nodoc
class __$$TrackingSummaryImplCopyWithImpl<$Res>
    extends _$TrackingSummaryCopyWithImpl<$Res, _$TrackingSummaryImpl>
    implements _$$TrackingSummaryImplCopyWith<$Res> {
  __$$TrackingSummaryImplCopyWithImpl(
      _$TrackingSummaryImpl _value, $Res Function(_$TrackingSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? section = null,
    Object? count = null,
    Object? subtitle = freezed,
    Object? left = null,
    Object? right = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$TrackingSummaryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      left: null == left
          ? _value.left
          : left // ignore: cast_nullable_to_non_nullable
              as String,
      right: null == right
          ? _value.right
          : right // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingSummaryImpl implements _TrackingSummary {
  const _$TrackingSummaryImpl(
      {required this.name,
      required this.section,
      this.count = 0,
      this.subtitle,
      this.left = '',
      this.right = '',
      @DateTimeNullableConverter() this.createdAt});

  factory _$TrackingSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingSummaryImplFromJson(json);

  @override
  final String name;
  @override
  final String section;
  @override
  @JsonKey()
  final int count;
  @override
  final String? subtitle;
  @override
  @JsonKey()
  final String left;
  @override
  @JsonKey()
  final String right;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TrackingSummary(name: $name, section: $section, count: $count, subtitle: $subtitle, left: $left, right: $right, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingSummaryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.right, right) || other.right == right) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, section, count, subtitle, left, right, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingSummaryImplCopyWith<_$TrackingSummaryImpl> get copyWith =>
      __$$TrackingSummaryImplCopyWithImpl<_$TrackingSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingSummaryImplToJson(
      this,
    );
  }
}

abstract class _TrackingSummary implements TrackingSummary {
  const factory _TrackingSummary(
          {required final String name,
          required final String section,
          final int count,
          final String? subtitle,
          final String left,
          final String right,
          @DateTimeNullableConverter() final DateTime? createdAt}) =
      _$TrackingSummaryImpl;

  factory _TrackingSummary.fromJson(Map<String, dynamic> json) =
      _$TrackingSummaryImpl.fromJson;

  @override
  String get name;
  @override
  String get section;
  @override
  int get count;
  @override
  String? get subtitle;
  @override
  String get left;
  @override
  String get right;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TrackingSummaryImplCopyWith<_$TrackingSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
