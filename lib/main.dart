import 'package:easy_localization/easy_localization.dart' as easy_local;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:logger/logger.dart';

import 'presentation/application.dart';

late Logger logger;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await easy_local.EasyLocalization.ensureInitialized();
  _initLogger();

  await setupLocators(Environment.dev);
  runApp(const MyApp());
}

void _initLogger() {
  logger = Logger(
      printer: PrettyPrinter(
    methodCount: 1,
  ));
}
