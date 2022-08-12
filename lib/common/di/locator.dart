import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/common/di/locator.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> setupLocators(String environment) async {
  final gh = GetItHelper(getIt, environment);
  $initGetIt(getIt, environment: environment);
}
