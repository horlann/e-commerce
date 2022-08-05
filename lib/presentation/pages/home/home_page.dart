import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';
import 'components/all_products.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedInputField(
                icon: Icons.search,
                hint: "Search",
                callback: (String callback) {},
                validation: (value) => null,
              ),
            ),
            const PopularProducts(),
            const AllProducts(),
          ],
        ),
      ),
    );
  }
}
