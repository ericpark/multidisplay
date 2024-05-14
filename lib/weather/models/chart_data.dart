import 'package:flutter/material.dart';

class ChartData {
  ChartData(this.x, this.y, this.pointColorMapper);

  final DateTime x;
  final double y;
  final Color? pointColorMapper;
}
