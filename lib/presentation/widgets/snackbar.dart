import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

class CustomSnackBar {
  static void showSnackNar(BuildContext context, String title, String subtitle) {
    Flushbar(
      title: title,
      message: subtitle,
      duration: const Duration(milliseconds: 1500),
    ).show(context);
  }
}
