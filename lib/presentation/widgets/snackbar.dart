import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

class CustomSnackBar {
  static void showSnackNar(BuildContext context, String title, String subtitle) {
    Flushbar(
      title: title,
      message: subtitle,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
