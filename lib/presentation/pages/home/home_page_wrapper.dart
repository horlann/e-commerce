import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/di/locator.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_event.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductsBloc(getIt.call())..add(const InitEvent()),
      child: AutoRouter(
        placeholder: (context) => ColoredBox(
          color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
        ),
      ),
    );
  }
}
