import 'package:flutter/material.dart';

import 'abstract_theme.dart';

class LightTheme implements AbstractTheme {
  @override
  Color get backgroundColor => const Color(0xFFeff2f6);

  @override
  Color get infoTextColor => const Color(0xFF1a191e);

  @override
  Color get inactiveTextColor => const Color(0xFF6f6e75);

  @override
  Color get accentColor => const Color(0xFFFFC100);

  @override
  Color get darkAccentColor => const Color(0xFFFF9400);

  @override
  Color get lightAccentColor => const Color.fromARGB(255, 255, 207, 64);

  @override
  Color get cardColor => const Color(0xFFf9f8fd);

  @override
  Color get wrongColor => const Color(0xFFc85648);

  @override
  Color get rightColor => const Color(0xFF24ad65);

  @override
  Color get whiteTextColor => const Color(0xFFFFFFFF);

  @override
  Color get mainTextColor => const Color(0xff35383F);

  @override
  Color get secondaryTextColor => const Color(0xff425567);

  @override
  Color get tertiaryTextColor => const Color(0xff97A9B9);

  @override
  Color get secondaryAccentColor => const Color(0xffFF7933);

  @override
  Color get baseColor => const Color(0xff3B6EA5);

  @override
  Color get mainColor => const Color(0xff498FD4);

  @override
  Color get navigationActiveColor => const Color(0xffEFF2F6);

  @override
  Color get inactiveColor => const Color(0xffBAC5D9);

  @override
  Color get fillColor => const Color(0xffE1E7EF);

  @override
  AppShadows get appShadows => _LightAppShadows();

  @override
  FontStyles get fontStyles => FontStyles();

  @override
  Color get secondBackgroundColor => const Color(0xFFeff2f6);
}

class _LightAppShadows implements AppShadows {
  @override
  BoxShadow xLargeShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0.12), offset: const Offset(0, 4), blurRadius: 4, spreadRadius: 0);
  @override
  BoxShadow largeShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0.16), offset: const Offset(0, 2), blurRadius: 8, spreadRadius: 0);
  @override
  BoxShadow mediumShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0.1), offset: const Offset(0, 7), blurRadius: 4, spreadRadius: 0);
  @override
  BoxShadow baseShadow = BoxShadow(
      color: const Color(0xff000000).withOpacity(0.15), offset: const Offset(0, 0), blurRadius: 2, spreadRadius: 0);
}
