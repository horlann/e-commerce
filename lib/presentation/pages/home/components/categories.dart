import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/screens/category.dart';
import 'package:kurilki/presentation/screens/constants.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 84,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryCard(
              icon: demo_categories[0].icon,
              title: demo_categories[0].title,
              press: () {},
            ),
            CategoryCard(
              icon: demo_categories[1].icon,
              title: demo_categories[1].title,
              press: () {},
            ),
            CategoryCard(
              icon: demo_categories[2].icon,
              title: demo_categories[2].title,
              press: () {},
            ),
          ],
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return InkWell(
      onTap: () {
        BlocProvider.of<ProductsBloc>(context).add(CreateItemEvent());
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), color: theme.rightColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2, horizontal: 12),
          child: Column(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(height: defaultPadding / 2),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
