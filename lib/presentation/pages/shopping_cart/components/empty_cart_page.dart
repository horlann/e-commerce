import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:lottie/lottie.dart';

class EmptyCartPage extends StatelessWidget {
  const EmptyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Column(
      children: [
        Expanded(
          child: Lottie.asset('assets/animations/empty_cart.json'),
          flex: 2,
        ),
        Expanded(
          child: Text(
            'Cart is Empty',
            style: TextStyle(color: theme.infoTextColor, fontSize: 21, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
