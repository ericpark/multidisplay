import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackerFormBloc extends FormBloc<String, String> {
  TrackerFormBloc(
      {List<String>? sectionList,
      List<String>? trackingTypeList,
      Map<String, List<String>>? metricsMap})
      : sectionList = sectionList ?? [""],
        trackingTypeList = trackingTypeList ?? [""],
        metricsMap = metricsMap ?? {} {
    addFieldBlocs(
      fieldBlocs: [
        name,
        section,
        description,
        trackingType,
        setThresholds,
        mainMetric,
        leftMetric,
        rightMetric,
      ],
    );
    setThresholds.onValueChanges(onData: (previous, current) async* {
      removeFieldBlocs(
        fieldBlocs: [setThresholds, mainMetric],
      );
      if (current.value) {
        addFieldBlocs(
          fieldBlocs: [setThresholds, mainMetric],
        );
      } else {
        addFieldBlocs(
          fieldBlocs: [setThresholds, mainMetric],
        );
      }
    });

    trackingType.onValueChanges(onData: (previous, current) async* {
      removeFieldBlocs(
        fieldBlocs: [mainMetric, leftMetric, rightMetric],
      );
      rightMetric = rightMetric.copyWith(
        metricType: SelectFieldBloc(
          name: 'trackingType',
          items: metricsMap![trackingType.value ?? ""] ?? ["days_ago"],
        ),
      );

      leftMetric = leftMetric.copyWith(
        metricType: SelectFieldBloc(
          name: 'trackingType',
          items: metricsMap[trackingType.value ?? ""] ?? ["days_ago"],
        ),
      );

      mainMetric = mainMetric.copyWith(
        metricType: SelectFieldBloc(
          name: 'trackingType',
          items: metricsMap[trackingType.value ?? ""] ?? ["days_ago"],
          //initialValue: metricsMap[trackingType.value ?? ""]![0],
        ),
      );

      addFieldBlocs(
        fieldBlocs: [mainMetric, leftMetric, rightMetric],
      );
    });
  }

  final List<String> sectionList;
  final List<String> trackingTypeList;
  final Map<String, List<String>> metricsMap;

  final name = TextFieldBloc(
    name: 'name',
    validators: [
      FieldBlocValidators.required,
    ],
  );

  late final section = SelectFieldBloc(
      name: 'section',
      items: sectionList,
      initialValue: sectionList.isNotEmpty ? sectionList[0] : null);

  final description = TextFieldBloc(
    name: 'description',
  );

  late final trackingType = SelectFieldBloc(
    name: 'trackingType',
    items: trackingTypeList,
    initialValue: "days_ago",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final setThresholds = BooleanFieldBloc();

  late var mainMetric = MetricsFieldBloc(
    displayName: TextFieldBloc(name: 'display_name'),
    metricType: SelectFieldBloc(
      name: 'trackingType',
      items: metricsMap[trackingType.value ?? ""] ?? ["days_ago"],
      //initialValue: (metricsMap[trackingType.value ?? ""] ?? ["days_ago"])[0],
    ),
    goodThresholdStart: TextFieldBloc(name: "goodThresholdStart"),
    goodThresholdEnd: TextFieldBloc(name: "goodThresholdEnd"),
    warnThresholdStart: TextFieldBloc(name: "warnThresholdStart"),
    warnThresholdEnd: TextFieldBloc(name: "warnThresholdEnd"),
    poorThresholdStart: TextFieldBloc(name: "poorThresholdStart"),
    poorThresholdEnd: TextFieldBloc(name: "poorThresholdEnd"),
  );

  late var rightMetric = MetricsFieldBloc(
    displayName: TextFieldBloc(name: 'displayName'),
    metricType: SelectFieldBloc(
      name: 'trackingType',
      items: metricsMap[trackingType.value ?? ""] ?? ["days_ago"],
      //initialValue: (metricsMap[trackingType.value ?? ""] ?? ["days_ago"])[0],
    ),
  );

  late var leftMetric = MetricsFieldBloc(
    displayName: TextFieldBloc(name: 'displayName'),
    metricType: SelectFieldBloc(
      name: 'trackingType',
      items: metricsMap[trackingType.value ?? ""] ?? ["days_ago"],
      // initialValue: (metricsMap[trackingType.value ?? ""] ?? ["days_ago"])[0],
    ),
  );

  TrackingSummary toTrackingSummary() {
    Map<String, Map<String, String>> metrics = {};
    Map<String, Map<String, Map<String, double>>> thresholds = {};

    if (mainMetric.metricType.value != null ||
        mainMetric.metricType.value != "") {
      metrics[mainMetric.metricType.value!] = mainMetric.toMetrics();
    }
    if (leftMetric.metricType.value != null &&
        leftMetric.metricType.value != "") {
      metrics[leftMetric.metricType.value!] = leftMetric.toMetrics();
    }
    if (rightMetric.metricType.value != null &&
        rightMetric.metricType.value != "") {
      metrics[rightMetric.metricType.value!] = rightMetric.toMetrics();
    }

    if (setThresholds.value) {
      thresholds[mainMetric.metricType.value!] = mainMetric.toThresholds();
    }
    return TrackingSummary(
      name: name.value,
      description: description.value,
      section: section.value!,
      ownerId: 'default',
      id: '',
      autoUpdate: true,
      trackingType: trackingType.value!,
      metrics: metrics,
      mainMetric: mainMetric.metricType.value ?? "",
      leftMetric: leftMetric.metricType.value ?? "",
      rightMetric: rightMetric.metricType.value ?? "",
      thresholds: thresholds,
    );
  }

  @override
  Future<void> onSubmitting() async {
    emitSuccess(
      canSubmitAgain: true,
      /*(successResponse: const JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),*/
    );
  }
}

class MetricsFieldBloc extends GroupFieldBloc {
  MetricsFieldBloc({
    required this.displayName,
    required this.metricType,
    this.goodThresholdStart,
    this.goodThresholdEnd,
    this.warnThresholdStart,
    this.warnThresholdEnd,
    this.poorThresholdStart,
    this.poorThresholdEnd,
  }) : super(fieldBlocs: [
          displayName,
          metricType,
          goodThresholdStart ?? TextFieldBloc(initialValue: "0"),
          goodThresholdEnd ?? TextFieldBloc(initialValue: "0"),
          warnThresholdStart ?? TextFieldBloc(initialValue: "0"),
          warnThresholdEnd ?? TextFieldBloc(initialValue: "0"),
          poorThresholdStart ?? TextFieldBloc(initialValue: "0"),
          poorThresholdEnd ?? TextFieldBloc(initialValue: "0"),
        ]);

  final TextFieldBloc displayName;
  final SelectFieldBloc<String, dynamic> metricType;
  final TextFieldBloc? goodThresholdStart;
  final TextFieldBloc? goodThresholdEnd;
  final TextFieldBloc? warnThresholdStart;
  final TextFieldBloc? warnThresholdEnd;
  final TextFieldBloc? poorThresholdStart;
  final TextFieldBloc? poorThresholdEnd;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['metricType'] = metricType;
    return data;
  }

  Map<String, String> toMetrics() {
    return {"display_name": displayName.value, "value": "0"};
  }

  Map<String, Map<String, double>> toThresholds() {
    return {
      "good": {
        "start": goodThresholdStart!.valueToDouble ?? 0.0,
        "end": goodThresholdEnd!.valueToDouble ?? 0.0,
      },
      "warn": {
        "start": warnThresholdStart!.valueToDouble ?? 0.0,
        "end": warnThresholdEnd!.valueToDouble ?? 0.0,
      },
      "poor": {
        "start": poorThresholdStart!.valueToDouble ?? 0.0,
        "end": poorThresholdEnd!.valueToDouble ?? 0.0,
      },
    };
  }

  MetricsFieldBloc copyWith({
    TextFieldBloc? displayName,
    SelectFieldBloc<String, dynamic>? metricType,
    TextFieldBloc? goodThresholdStart,
    TextFieldBloc? goodThresholdEnd,
    TextFieldBloc? warnThresholdStart,
    TextFieldBloc? warnThresholdEnd,
    TextFieldBloc? poorThresholdStart,
    TextFieldBloc? poorThresholdEnd,
  }) {
    return MetricsFieldBloc(
      displayName: displayName ?? this.displayName,
      metricType: metricType ?? this.metricType,
      goodThresholdStart: goodThresholdStart ?? this.goodThresholdStart,
      goodThresholdEnd: goodThresholdEnd ?? this.goodThresholdEnd,
      warnThresholdStart: warnThresholdStart ?? this.warnThresholdStart,
      warnThresholdEnd: warnThresholdEnd ?? this.warnThresholdEnd,
      poorThresholdStart: poorThresholdStart ?? this.poorThresholdStart,
      poorThresholdEnd: poorThresholdEnd ?? this.poorThresholdEnd,
    );
  }
}
