import 'package:flutter/material.dart';

extension NumExtensions on num {
  double hp(BuildContext context) => MediaQuery.of(context).size.height * this / 100;
  double wp(BuildContext context) => MediaQuery.of(context).size.width * this / 100;
  double sp(BuildContext context) => MediaQuery.of(context).textScaler.scale(toDouble() / 100);
  double dp(BuildContext context) => MediaQuery.of(context).devicePixelRatio * this;
}
