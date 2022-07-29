import 'package:flutter/material.dart';

abstract class AbstractTheme {
  AbstractTheme(
    this.backgroundColor,
    this.infoTextColor,
    this.inactiveTextColor,
    this.accentColor,
    this.lightAccentColor,
    this.darkAccentColor,
    this.cardColor,
    this.wrongColor,
    this.rightColor,
    this.whiteTextColor,
    this.appShadows,
    this.fontStyles,
  );

  final Color backgroundColor;
  final Color infoTextColor;
  final Color inactiveTextColor;
  final Color accentColor;
  final Color lightAccentColor;
  final Color darkAccentColor;
  final Color cardColor;
  final Color wrongColor;
  final Color rightColor;
  final Color whiteTextColor;
  final AppShadows appShadows;
  final FontStyles fontStyles;
}

abstract class AppShadows {
  AppShadows(this.xLargeShadow, this.largeShadow, this.mediumShadow, this.baseShadow);

  final BoxShadow xLargeShadow;
  final BoxShadow largeShadow;
  final BoxShadow mediumShadow;
  final BoxShadow baseShadow;
}

class FontStyles {
  ///use .copyWith() to change style params
  final regular34 = const TextStyle(fontSize: 34, fontWeight: FontWeight.w400);
  final bold26 = const TextStyle(fontSize: 26, fontWeight: FontWeight.w700);
  final regular26 = const TextStyle(fontSize: 26, fontWeight: FontWeight.w400);
  final semiBold22 = const TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  final regular22 = const TextStyle(fontSize: 22, fontWeight: FontWeight.w400);
  final semiBold18 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  final regular18 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  final regular16 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  final semiBold16 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  final semiBold14 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  final regular12 = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  final semiBold12 = const TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  final bold30 = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
}
