import 'package:flutter/material.dart';

class CustomScrollBehaviour extends ScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
