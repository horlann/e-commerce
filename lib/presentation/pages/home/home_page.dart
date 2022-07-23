import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BlocProvider.of<ThemesBloc>(context).theme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: const [
            Categories(),
            NewArrivalProducts(),
            SizedBox(
              height: 20,
            ),
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}
