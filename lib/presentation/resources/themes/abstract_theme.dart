import 'package:flutter/material.dart';

abstract class AbstractTheme {
  AbstractTheme(
    this.backgroundColor,
    this.infoTextColor,
    this.inactiveTextColor,
    this.accentColor,
    this.cardColor,
    this.wrongColor,
    this.rightColor,
    this.appShadows,
  );

  final Color backgroundColor;
  final Color infoTextColor;
  final Color inactiveTextColor;
  final Color accentColor;
  final Color cardColor;
  final Color wrongColor;
  final Color rightColor;
  final AppShadows appShadows;
}

abstract class AppShadows {
  AppShadows(this.xLargeShadow, this.largeShadow, this.mediumShadow, this.baseShadow);

  final BoxShadow xLargeShadow;
  final BoxShadow largeShadow;
  final BoxShadow mediumShadow;
  final BoxShadow baseShadow;
}
