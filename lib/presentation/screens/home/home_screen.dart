import 'package:flutter/material.dart';
import 'package:kurilki/presentation/screens/constants.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          "Explore",
          style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const Text(
          "best Outfits for you",
          style: TextStyle(fontSize: 18),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: defaultPadding),
          child: SearchForm(),
        ),
        const Categories(),
        const NewArrivalProducts(),
        const PopularProducts(),
      ],
    );
  }
}
