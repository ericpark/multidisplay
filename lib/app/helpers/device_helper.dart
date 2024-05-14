import 'dart:math';

import 'package:flutter/material.dart';

enum FormFactor { mobile, tablet, desktop }

class DeviceType {
  const DeviceType._({
    required this.deviceType,
    required this.screenWidth,
    required this.screenHeight,
    required this.formFactor,
  });

  DeviceType.fromBuildContext(BuildContext context)
      : this._(
            deviceType: getDeviceType(context),
            screenHeight: MediaQuery.of(context).size.height,
            screenWidth: MediaQuery.of(context).size.width,
            formFactor: getDeviceFormFactor(context),);

  final String deviceType;
  final double screenWidth;
  final double screenHeight;
  final FormFactor formFactor;

  static String getDeviceType(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final diagonalSize = sqrt(
      (screenWidth * screenWidth) + (screenHeight * screenHeight),
    );

    const thresholdPhone = 700.0;
    const thresholdPhablet = 1100.0;
    const thresholdTablet = 1500.0;

    if (diagonalSize < thresholdPhone) {
      return 'Phone';
    } else if (diagonalSize < thresholdPhablet) {
      return 'Phablet';
    } else if (diagonalSize < thresholdTablet) {
      return 'Tablet';
    } else {
      return 'Larger Device';
    }
  }

  static FormFactor getDeviceFormFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final diagonalSize = sqrt(
      (screenWidth * screenWidth) + (screenHeight * screenHeight),
    );

    const thresholdPhone = 700.0;
    const thresholdPhablet = 1100.0;
    const thresholdTablet = 1500.0;

    if (diagonalSize < thresholdPhone) {
      return FormFactor.mobile;
    } else if (diagonalSize < thresholdPhablet) {
      return FormFactor.mobile;
    } else if (diagonalSize < thresholdTablet) {
      return FormFactor.tablet;
    } else {
      return FormFactor.desktop;
    }
  }
}
