import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/cart/cart_bloc.dart';
import 'package:kurilki/presentation/bloc/cart/cart_event.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_event.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemesBloc>(create: (_) => ThemesBloc()..add(const ThemeInitEvent())),
        BlocProvider<AccountBloc>(create: (_) => getIt<AccountBloc>()..add(const InitAuthEvent())),
        BlocProvider<CartBloc>(create: (_) => CartBloc(getIt.call(), getIt.call())..add(const InitCartEvent())),
      ],
      child: Builder(
        builder: (context) {
          initializeDateFormatting();
          return MaterialApp.router(
            color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
            debugShowCheckedModeBanner: false,
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),
            builder: (context, router) => router!,
          );
        },
      ),
    );
  }
}
