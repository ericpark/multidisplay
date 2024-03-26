import 'package:flutter/material.dart';
import 'package:multidisplay/weather/weather.dart';

extension TemperatureExtensions on Temperature {
  Color get color {
    final temp = value;
    if (temp <= 20) {
      return const Color(0xff5C04FE); // freezing
    } else if (temp <= 25) {
      return const Color(0xff6633FE); // very very very cold
    } else if (temp <= 30) {
      return const Color(0xff6663FB); // very very cold
    } else if (temp <= 35) {
      return const Color(0xff7B87FF); // very cold
    } else if (temp <= 40) {
      return const Color(0xff90A8FF); // cold
    } else if (temp <= 45) {
      return const Color(0xffA8C0FE); // getting cold
    } else if (temp <= 50) {
      return const Color(0xffB3D0F2); // cool
    } else if (temp <= 52) {
      return const Color(0xffBFDDE7);
    } else if (temp <= 54) {
      return const Color(0xffCBE8DB);
    } else if (temp <= 56) {
      return const Color(0xffD9F3CC);
    } else if (temp <= 58) {
      return const Color(0xffE7FFB1);
    } else if (temp <= 60) {
      return const Color(0xffF3FEB0);
    } else if (temp <= 62) {
      return const Color(0xffFEFEA9);
    } else if (temp <= 64) {
      return const Color(0xffFFFE94);
    } else if (temp <= 66) {
      return const Color(0xffFFFC8A);
    } else if (temp <= 68) {
      return const Color(0xffFEEC7C);
    } else if (temp <= 70) {
      return const Color(0xffFFDD73);
    } else if (temp <= 72) {
      return const Color(0xffFFD370);
    } else if (temp < 74) {
      return const Color(0xffFEC86E);
    } else if (temp <= 75) {
      return const Color(0xffFEB068); // pretty warm
    } else if (temp <= 80) {
      return const Color(0xffFD9B5D); // getting hot
    } else if (temp <= 85) {
      return const Color(0xffFE765C); // hot
    } else if (temp <= 90) {
      return const Color(0xffFB685F); // very hot
    } else if (temp <= 95) {
      return const Color(0xffFD5757); // very very hot
    } else {
      return const Color(0xffFC453B); // very very very hot
    }
  }
}
