 import 'package:flutter/material.dart';

double byWithScale(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  if (deviceWidth > 520) return 1.9;
  if (deviceWidth > 470) return 1.7;
  if (deviceWidth > 430) return 1.5;
  if (deviceWidth > 400) return 1.3;
  if (deviceWidth > 350) return 1.2;
  if (deviceWidth > 320) return 1.05;
  return 1;
}

