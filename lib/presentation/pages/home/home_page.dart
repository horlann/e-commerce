import 'package:flutter/material.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
