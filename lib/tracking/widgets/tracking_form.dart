import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingForm extends StatelessWidget {
  const TrackingForm({
    super.key,
    this.trackingSummary,
  });

  final TrackingSummary? trackingSummary;

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<TrackerFormBloc>(context, listen: true);

    if (trackingSummary != null) {
      TrackingSummary eventData = trackingSummary!;

      formBloc.name.updateInitialValue(eventData.name);
      formBloc.description.updateInitialValue(eventData.description);
    }
    formBloc.setThresholds.updateInitialValue(formBloc.setThresholds.value);

    return FormBlocListener<TrackerFormBloc, String, String>(
      onSuccess: (context, state) {
        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.successResponse!),
              duration: const Duration(seconds: 2),
            ));*/
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.name,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Tracker Name',
                prefixIcon: Icon(Icons.people),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
            DropdownFieldBlocBuilder<String>(
              selectFieldBloc: formBloc.section,
              decoration: const InputDecoration(
                labelText: 'Section',
                prefixIcon: Icon(Icons.table_rows),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                  child: Icon(
                    Icons.emergency,
                    size: 10,
                  ),
                ),
              ),
              itemBuilder: (context, value) => FieldItem(
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 9,
                    child: Text(value),
                  ),
                  Expanded(flex: 5, child: Container()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ]),
              ),
            ),
            DropdownFieldBlocBuilder<String>(
              selectFieldBloc: formBloc.trackingType,
              decoration: const InputDecoration(
                labelText: 'Tracking Type',
                prefixIcon: Icon(Icons.control_camera_outlined),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                  child: Icon(
                    Icons.emergency,
                    size: 10,
                  ),
                ),
              ),
              itemBuilder: (context, value) => FieldItem(
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 9,
                    child: Text(value),
                  ),
                  Expanded(flex: 5, child: Container()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ]),
              ),
            ),
            Flex(direction: Axis.horizontal, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MetricTypeSection(
                            metricFieldBloc: formBloc.mainMetric,
                            name: "Main Metric")),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SwitchFieldBlocBuilder(
                      booleanFieldBloc: formBloc.setThresholds,
                      body: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('Set Thresholds?'),
                      ),
                    ),
                    formBloc.setThresholds.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ThresholdSection(
                                metricFieldBloc: formBloc.mainMetric, name: ""),
                          )
                        : Container(),
                  ])),
            ]),
            const Text("Optional"),
            const Divider(),
            Flex(direction: Axis.horizontal, children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MetricTypeSection(
                      metricFieldBloc: formBloc.leftMetric,
                      name: "Left Metric",
                    )),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MetricTypeSection(
                      metricFieldBloc: formBloc.rightMetric,
                      name: "Right Metric",
                    )),
              ),
            ]),
            TextFieldBlocBuilder(
              textFieldBloc: formBloc.description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              minLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class MetricTypeSection extends StatelessWidget {
  const MetricTypeSection(
      {super.key, required this.metricFieldBloc, required this.name});

  final MetricsFieldBloc metricFieldBloc;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(name),
        TextFieldBlocBuilder(
          textFieldBloc: metricFieldBloc.displayName,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Display Name',
            prefixIcon: Icon(Icons.title),
            suffixIcon: Icon(
              Icons.emergency,
              size: 10,
            ),
          ),
        ),
        DropdownFieldBlocBuilder<String>(
          selectFieldBloc: metricFieldBloc.metricType,
          decoration: const InputDecoration(
            labelText: 'Measurement',
            prefixIcon: Icon(Icons.track_changes_outlined),
            suffixIcon: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: Icon(
                Icons.emergency,
                size: 10,
              ),
            ),
          ),
          itemBuilder: (context, value) => FieldItem(
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                flex: 9,
                child: Text(value),
              ),
              Expanded(flex: 5, child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: Container(color: Colors.transparent),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class ThresholdSection extends StatelessWidget {
  const ThresholdSection(
      {super.key, required this.metricFieldBloc, required this.name});

  final MetricsFieldBloc metricFieldBloc;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flex(direction: Axis.horizontal, children: [
          const Text("Good"),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.goodThresholdStart!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'start',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.goodThresholdEnd!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'end',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
        ]),
        Flex(direction: Axis.horizontal, children: [
          const Text("Warn"),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.warnThresholdStart!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'start',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.warnThresholdEnd!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'end',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
        ]),
        Flex(direction: Axis.horizontal, children: [
          const Text("Poor"),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.poorThresholdStart!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'start',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
          Expanded(
            child: TextFieldBlocBuilder(
              textFieldBloc: metricFieldBloc.poorThresholdEnd!,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'end',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: Icon(
                  Icons.emergency,
                  size: 10,
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
