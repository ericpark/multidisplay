import 'package:multidisplay/tracking/tracking.dart';

mixin TrackingWidget {
  late final int id;
  late final String section;
  late final TrackingSummary trackingSummary;

  final emptyMetric = const {"display_name": "", "value": ""};
}
