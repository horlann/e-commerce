import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_event.dart';
import 'screens/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      lazy: false,
      create: (context) => ThemesBloc()..add(const ThemeInitEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'The Flutter Way',
        theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          primarySwatch: Colors.blue,
          fontFamily: "Gordita",
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      ),
    );
  }
}
