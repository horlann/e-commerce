import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/pages/home/components/product_card.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    if (items.isNotEmpty) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(adaptiveWidth(8.0)),
          child: SizedBox(
            height: adaptiveHeight(getScreenHeight),
            child: Column(
              children: List.generate(
                items.length,
                (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: adaptiveWidth(4)),
                    child: ProductCard(
                      product: items[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return Center(
          child: Text(
        Strings.nothingFound,
        style: theme.fontStyles.regular18,
      ));
    }
  }
}
