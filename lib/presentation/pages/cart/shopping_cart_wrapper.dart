import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class ShoppingCartWrapper extends StatelessWidget {
  const ShoppingCartWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoRouter(
      placeholder: (context) => ColoredBox(
        color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
      ),
    );
  }
}
