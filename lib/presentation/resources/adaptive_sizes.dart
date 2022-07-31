import 'package:flutter/material.dart';

late double _screenHeight;
late double _screenWidth;

void setScreenHeight(double height) => _screenHeight = height;

void setScreenWidth(double width) => _screenWidth = width;

double adaptiveHeight(double elementHeight, {double? screenHeight}) =>
    (screenHeight ?? _screenHeight) * elementHeight / maxAppHeight;

double adaptiveWidth(double elementWidth, {double? screenWidth}) =>
    (screenWidth ?? _screenWidth) * elementWidth / maxAppWidth;

double adaptiveFontSize(TextStyle textStyle, {double? screenWidth}) =>
    ((screenWidth ?? _screenWidth) * textStyle.fontSize! / maxAppWidth).floor().toDouble();

double adaptiveFontSizeRaw(double fontSize, {double? screenWidth}) =>
    ((screenWidth ?? _screenWidth) * fontSize / maxAppWidth).floor().toDouble();

TextStyle adaptiveTextStyle(TextStyle textStyle, {double? screenWidth}) =>
    textStyle.copyWith(fontSize: ((screenWidth ?? _screenWidth) * textStyle.fontSize! / 375).floor().toDouble());

const int maxAppHeight = 812;
const int maxAppWidth = 375;
