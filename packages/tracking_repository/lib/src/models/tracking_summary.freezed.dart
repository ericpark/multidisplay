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
  String? get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get trackingType => throw _privateConstructorUsedError;
  String get trackingSubtitle => throw _privateConstructorUsedError;
  String get mainMetric => throw _privateConstructorUsedError;
  String get leftMetric => throw _privateConstructorUsedError;
  String get rightMetric => throw _privateConstructorUsedError;
  bool get autoUpdate => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get metrics =>
      throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

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
      {String? id,
      String ownerId,
      String name,
      String section,
      int total,
      String description,
      String trackingType,
      String trackingSubtitle,
      String mainMetric,
      String leftMetric,
      String rightMetric,
      bool autoUpdate,
      Map<String, Map<String, String>> metrics,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
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
    Object? id = freezed,
    Object? ownerId = null,
    Object? name = null,
    Object? section = null,
    Object? total = null,
    Object? description = null,
    Object? trackingType = null,
    Object? trackingSubtitle = null,
    Object? mainMetric = null,
    Object? leftMetric = null,
    Object? rightMetric = null,
    Object? autoUpdate = null,
    Object? metrics = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      trackingType: null == trackingType
          ? _value.trackingType
          : trackingType // ignore: cast_nullable_to_non_nullable
              as String,
      trackingSubtitle: null == trackingSubtitle
          ? _value.trackingSubtitle
          : trackingSubtitle // ignore: cast_nullable_to_non_nullable
              as String,
      mainMetric: null == mainMetric
          ? _value.mainMetric
          : mainMetric // ignore: cast_nullable_to_non_nullable
              as String,
      leftMetric: null == leftMetric
          ? _value.leftMetric
          : leftMetric // ignore: cast_nullable_to_non_nullable
              as String,
      rightMetric: null == rightMetric
          ? _value.rightMetric
          : rightMetric // ignore: cast_nullable_to_non_nullable
              as String,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      {String? id,
      String ownerId,
      String name,
      String section,
      int total,
      String description,
      String trackingType,
      String trackingSubtitle,
      String mainMetric,
      String leftMetric,
      String rightMetric,
      bool autoUpdate,
      Map<String, Map<String, String>> metrics,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
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
    Object? id = freezed,
    Object? ownerId = null,
    Object? name = null,
    Object? section = null,
    Object? total = null,
    Object? description = null,
    Object? trackingType = null,
    Object? trackingSubtitle = null,
    Object? mainMetric = null,
    Object? leftMetric = null,
    Object? rightMetric = null,
    Object? autoUpdate = null,
    Object? metrics = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$TrackingSummaryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      trackingType: null == trackingType
          ? _value.trackingType
          : trackingType // ignore: cast_nullable_to_non_nullable
              as String,
      trackingSubtitle: null == trackingSubtitle
          ? _value.trackingSubtitle
          : trackingSubtitle // ignore: cast_nullable_to_non_nullable
              as String,
      mainMetric: null == mainMetric
          ? _value.mainMetric
          : mainMetric // ignore: cast_nullable_to_non_nullable
              as String,
      leftMetric: null == leftMetric
          ? _value.leftMetric
          : leftMetric // ignore: cast_nullable_to_non_nullable
              as String,
      rightMetric: null == rightMetric
          ? _value.rightMetric
          : rightMetric // ignore: cast_nullable_to_non_nullable
              as String,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingSummaryImpl implements _TrackingSummary {
  _$TrackingSummaryImpl(
      {this.id,
      required this.ownerId,
      required this.name,
      required this.section,
      this.total = 0,
      this.description = '',
      this.trackingType = '',
      this.trackingSubtitle = '',
      this.mainMetric = '',
      this.leftMetric = '',
      this.rightMetric = '',
      this.autoUpdate = false,
      final Map<String, Map<String, String>> metrics = const {},
      this.active = true,
      @DateTimeNullableConverter() this.createdAt,
      final List<String>? tags = const []})
      : _metrics = metrics,
        _tags = tags;

  factory _$TrackingSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingSummaryImplFromJson(json);

  @override
  final String? id;
  @override
  final String ownerId;
  @override
  final String name;
  @override
  final String section;
  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String trackingType;
  @override
  @JsonKey()
  final String trackingSubtitle;
  @override
  @JsonKey()
  final String mainMetric;
  @override
  @JsonKey()
  final String leftMetric;
  @override
  @JsonKey()
  final String rightMetric;
  @override
  @JsonKey()
  final bool autoUpdate;
  final Map<String, Map<String, String>> _metrics;
  @override
  @JsonKey()
  Map<String, Map<String, String>> get metrics {
    if (_metrics is EqualUnmodifiableMapView) return _metrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metrics);
  }

  @override
  @JsonKey()
  final bool? active;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  final List<String>? _tags;
  @override
  @JsonKey()
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TrackingSummary(id: $id, ownerId: $ownerId, name: $name, section: $section, total: $total, description: $description, trackingType: $trackingType, trackingSubtitle: $trackingSubtitle, mainMetric: $mainMetric, leftMetric: $leftMetric, rightMetric: $rightMetric, autoUpdate: $autoUpdate, metrics: $metrics, active: $active, createdAt: $createdAt, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.trackingType, trackingType) ||
                other.trackingType == trackingType) &&
            (identical(other.trackingSubtitle, trackingSubtitle) ||
                other.trackingSubtitle == trackingSubtitle) &&
            (identical(other.mainMetric, mainMetric) ||
                other.mainMetric == mainMetric) &&
            (identical(other.leftMetric, leftMetric) ||
                other.leftMetric == leftMetric) &&
            (identical(other.rightMetric, rightMetric) ||
                other.rightMetric == rightMetric) &&
            (identical(other.autoUpdate, autoUpdate) ||
                other.autoUpdate == autoUpdate) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ownerId,
      name,
      section,
      total,
      description,
      trackingType,
      trackingSubtitle,
      mainMetric,
      leftMetric,
      rightMetric,
      autoUpdate,
      const DeepCollectionEquality().hash(_metrics),
      active,
      createdAt,
      const DeepCollectionEquality().hash(_tags));

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
  factory _TrackingSummary(
      {final String? id,
      required final String ownerId,
      required final String name,
      required final String section,
      final int total,
      final String description,
      final String trackingType,
      final String trackingSubtitle,
      final String mainMetric,
      final String leftMetric,
      final String rightMetric,
      final bool autoUpdate,
      final Map<String, Map<String, String>> metrics,
      final bool? active,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final List<String>? tags}) = _$TrackingSummaryImpl;

  factory _TrackingSummary.fromJson(Map<String, dynamic> json) =
      _$TrackingSummaryImpl.fromJson;

  @override
  String? get id;
  @override
  String get ownerId;
  @override
  String get name;
  @override
  String get section;
  @override
  int get total;
  @override
  String get description;
  @override
  String get trackingType;
  @override
  String get trackingSubtitle;
  @override
  String get mainMetric;
  @override
  String get leftMetric;
  @override
  String get rightMetric;
  @override
  bool get autoUpdate;
  @override
  Map<String, Map<String, String>> get metrics;
  @override
  bool? get active;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$TrackingSummaryImplCopyWith<_$TrackingSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
