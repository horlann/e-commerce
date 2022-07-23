import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_event.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      lazy: false,
      create: (context) => ThemesBloc()..add(const ThemeInitEvent()),
      child: Builder(builder: (context) {
        return MaterialApp.router(
          color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
          debugShowCheckedModeBanner: false,
          routeInformationParser: _appRouter.defaultRouteParser(),
          routerDelegate: _appRouter.delegate(),
          builder: (context, router) => router!,
        );
      }),
    );
  }
}
