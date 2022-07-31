import 'package:flutter/material.dart';

import 'abstract_theme.dart';

class DarkTheme implements AbstractTheme {
  @override
  Color get backgroundColor => const Color(0xFF1a191e);

  @override
  Color get infoTextColor => const Color(0xFFf0f0fa);

  @override
  Color get inactiveTextColor => const Color(0xFF6f6e75);

  @override
  Color get accentColor => const Color(0xFF5530b3);

  @override
  Color get darkAccentColor => const Color(0xFF5530b3);

  @override
  Color get lightAccentColor => const Color(0xFF5530b3);

  @override
  Color get cardColor => const Color(0xFF211f27);

  @override
  Color get wrongColor => const Color(0xFFc85648);

  @override
  Color get rightColor => const Color(0xFF24ad65);

  @override
  Color get whiteTextColor => const Color(0xFFFFFFFF);

  @override
  Color get mainTextColor => const Color(0xffFFFFFF);

  @override
  Color get secondaryTextColor => const Color(0xffFFFFFF);

  @override
  Color get tertiaryTextColor => const Color(0xff97A9B9);

  @override
  Color get secondaryAccentColor => const Color(0xffFF7933);

  @override
  Color get baseColor => const Color(0xff3B6EA5);

  @override
  Color get mainColor => const Color(0xff498FD4);

  @override
  Color get navigationActiveColor => const Color(0xff3B6EA5);

  @override
  Color get inactiveColor => const Color(0xff65738C);

  @override
  Color get fillColor => const Color(0xff2E3D50);

  @override
  Color get secondBackgroundColor => const Color(0xff19202B);

  @override
  AppShadows get appShadows => _DarkAppShadows();

  @override
  FontStyles get fontStyles => FontStyles();
}

class _DarkAppShadows implements AppShadows {
  @override
  BoxShadow xLargeShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0), offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 0);
  @override
  BoxShadow largeShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0), offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 0);
  @override
  BoxShadow mediumShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0), offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 0);
  @override
  BoxShadow baseShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0), offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 0);
}
