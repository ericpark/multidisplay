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
  @JsonKey(name: 'total')
  @JsonKey(name: 'count')
  int get count => throw _privateConstructorUsedError;
  @Deprecated("")
  @JsonKey(name: 'tracking_subtitle')
  String? get subtitle => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get mainMetric => throw _privateConstructorUsedError;
  String get leftMetric => throw _privateConstructorUsedError;
  String get rightMetric => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get metrics =>
      throw _privateConstructorUsedError;
  bool get autoUpdate => throw _privateConstructorUsedError;
  List<TrackingRecord> get records => throw _privateConstructorUsedError;
  String get trackingType => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get fetchedAt => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'total') @JsonKey(name: 'count') int count,
      @Deprecated("") @JsonKey(name: 'tracking_subtitle') String? subtitle,
      String id,
      String ownerId,
      String mainMetric,
      String leftMetric,
      String rightMetric,
      Map<String, Map<String, String>> metrics,
      bool autoUpdate,
      List<TrackingRecord> records,
      String trackingType,
      @DateTimeNullableConverter() DateTime? createdAt,
      @DateTimeNullableConverter() DateTime? fetchedAt});
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
    Object? id = null,
    Object? ownerId = null,
    Object? mainMetric = null,
    Object? leftMetric = null,
    Object? rightMetric = null,
    Object? metrics = null,
    Object? autoUpdate = null,
    Object? records = null,
    Object? trackingType = null,
    Object? createdAt = freezed,
    Object? fetchedAt = freezed,
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
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
      metrics: null == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as List<TrackingRecord>,
      trackingType: null == trackingType
          ? _value.trackingType
          : trackingType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(name: 'total') @JsonKey(name: 'count') int count,
      @Deprecated("") @JsonKey(name: 'tracking_subtitle') String? subtitle,
      String id,
      String ownerId,
      String mainMetric,
      String leftMetric,
      String rightMetric,
      Map<String, Map<String, String>> metrics,
      bool autoUpdate,
      List<TrackingRecord> records,
      String trackingType,
      @DateTimeNullableConverter() DateTime? createdAt,
      @DateTimeNullableConverter() DateTime? fetchedAt});
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
    Object? id = null,
    Object? ownerId = null,
    Object? mainMetric = null,
    Object? leftMetric = null,
    Object? rightMetric = null,
    Object? metrics = null,
    Object? autoUpdate = null,
    Object? records = null,
    Object? trackingType = null,
    Object? createdAt = freezed,
    Object? fetchedAt = freezed,
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
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
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
      metrics: null == metrics
          ? _value._metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      autoUpdate: null == autoUpdate
          ? _value.autoUpdate
          : autoUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value._records
          : records // ignore: cast_nullable_to_non_nullable
              as List<TrackingRecord>,
      trackingType: null == trackingType
          ? _value.trackingType
          : trackingType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingSummaryImpl extends _TrackingSummary {
  const _$TrackingSummaryImpl(
      {required this.name,
      required this.section,
      @JsonKey(name: 'total') @JsonKey(name: 'count') this.count = 0,
      @Deprecated("") @JsonKey(name: 'tracking_subtitle') this.subtitle,
      required this.id,
      required this.ownerId,
      this.mainMetric = '',
      this.leftMetric = '',
      this.rightMetric = '',
      final Map<String, Map<String, String>> metrics = const {},
      this.autoUpdate = false,
      final List<TrackingRecord> records = const [],
      this.trackingType = '',
      @DateTimeNullableConverter() this.createdAt,
      @DateTimeNullableConverter() this.fetchedAt})
      : _metrics = metrics,
        _records = records,
        super._();

  factory _$TrackingSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingSummaryImplFromJson(json);

  @override
  final String name;
  @override
  final String section;
  @override
  @JsonKey(name: 'total')
  @JsonKey(name: 'count')
  final int count;
  @override
  @Deprecated("")
  @JsonKey(name: 'tracking_subtitle')
  final String? subtitle;
  @override
  final String id;
  @override
  final String ownerId;
  @override
  @JsonKey()
  final String mainMetric;
  @override
  @JsonKey()
  final String leftMetric;
  @override
  @JsonKey()
  final String rightMetric;
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
  final bool autoUpdate;
  final List<TrackingRecord> _records;
  @override
  @JsonKey()
  List<TrackingRecord> get records {
    if (_records is EqualUnmodifiableListView) return _records;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_records);
  }

  @override
  @JsonKey()
  final String trackingType;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  @override
  @DateTimeNullableConverter()
  final DateTime? fetchedAt;

  @override
  String toString() {
    return 'TrackingSummary(name: $name, section: $section, count: $count, subtitle: $subtitle, id: $id, ownerId: $ownerId, mainMetric: $mainMetric, leftMetric: $leftMetric, rightMetric: $rightMetric, metrics: $metrics, autoUpdate: $autoUpdate, records: $records, trackingType: $trackingType, createdAt: $createdAt, fetchedAt: $fetchedAt)';
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
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.mainMetric, mainMetric) ||
                other.mainMetric == mainMetric) &&
            (identical(other.leftMetric, leftMetric) ||
                other.leftMetric == leftMetric) &&
            (identical(other.rightMetric, rightMetric) ||
                other.rightMetric == rightMetric) &&
            const DeepCollectionEquality().equals(other._metrics, _metrics) &&
            (identical(other.autoUpdate, autoUpdate) ||
                other.autoUpdate == autoUpdate) &&
            const DeepCollectionEquality().equals(other._records, _records) &&
            (identical(other.trackingType, trackingType) ||
                other.trackingType == trackingType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      section,
      count,
      subtitle,
      id,
      ownerId,
      mainMetric,
      leftMetric,
      rightMetric,
      const DeepCollectionEquality().hash(_metrics),
      autoUpdate,
      const DeepCollectionEquality().hash(_records),
      trackingType,
      createdAt,
      fetchedAt);

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

abstract class _TrackingSummary extends TrackingSummary {
  const factory _TrackingSummary(
          {required final String name,
          required final String section,
          @JsonKey(name: 'total') @JsonKey(name: 'count') final int count,
          @Deprecated("")
          @JsonKey(name: 'tracking_subtitle')
          final String? subtitle,
          required final String id,
          required final String ownerId,
          final String mainMetric,
          final String leftMetric,
          final String rightMetric,
          final Map<String, Map<String, String>> metrics,
          final bool autoUpdate,
          final List<TrackingRecord> records,
          final String trackingType,
          @DateTimeNullableConverter() final DateTime? createdAt,
          @DateTimeNullableConverter() final DateTime? fetchedAt}) =
      _$TrackingSummaryImpl;
  const _TrackingSummary._() : super._();

  factory _TrackingSummary.fromJson(Map<String, dynamic> json) =
      _$TrackingSummaryImpl.fromJson;

  @override
  String get name;
  @override
  String get section;
  @override
  @JsonKey(name: 'total')
  @JsonKey(name: 'count')
  int get count;
  @override
  @Deprecated("")
  @JsonKey(name: 'tracking_subtitle')
  String? get subtitle;
  @override
  String get id;
  @override
  String get ownerId;
  @override
  String get mainMetric;
  @override
  String get leftMetric;
  @override
  String get rightMetric;
  @override
  Map<String, Map<String, String>> get metrics;
  @override
  bool get autoUpdate;
  @override
  List<TrackingRecord> get records;
  @override
  String get trackingType;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  @DateTimeNullableConverter()
  DateTime? get fetchedAt;
  @override
  @JsonKey(ignore: true)
  _$$TrackingSummaryImplCopyWith<_$TrackingSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
