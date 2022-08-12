import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_event.dart';
import 'package:kurilki/presentation/bloc/products/products_state.dart';
import 'package:kurilki/presentation/pages/home/components/product_card.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Padding(
      padding: EdgeInsets.all(adaptiveWidth(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.allProducts,
            style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
          ),
          SizedBox(height: adaptiveHeight(10)),
          BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const SizedBox();
            } else if (state is ProductsLoadedState) {
              final List<Item> items = state.items;
              return Column(
                children: [
                  const _CategorySelector(),
                  SizedBox(height: adaptiveHeight(10)),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    child: items.isNotEmpty
                        ? Column(
                            children: List.generate(
                            items.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: adaptiveHeight(12)),
                                child: ProductCard(
                                  product: items[index],
                                ),
                              );
                            },
                          ))
                        : SizedBox(
                            height: adaptiveHeight(240),
                            child: Center(
                              child: Text(
                                Strings.noItems,
                                style: theme.fontStyles.semiBold18,
                              ),
                            ),
                          ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }
}

class _CategorySelector extends StatefulWidget {
  const _CategorySelector({Key? key}) : super(key: key);

  @override
  State<_CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<_CategorySelector> {
  int _selectedCategory = 1;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final ProductsBloc bloc = BlocProvider.of<ProductsBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: MainRoundedButton(
            text: Strings.allButton,
            border: Border.all(color: theme.mainTextColor, width: 2),
            color: _selectedCategory == 1 ? theme.mainTextColor : theme.cardColor,
            callback: () {
              _selectedCategory = 1;
              bloc.add(const ShowAllProductsEvent());
              setState(() {});
            },
            theme: theme,
            textStyle: theme.fontStyles.regular14.copyWith(
              color: _selectedCategory == 1 ? theme.whiteTextColor : theme.mainTextColor,
            ),
          ),
        ),
        SizedBox(width: adaptiveWidth(5)),
        Expanded(
          flex: 3,
          child: MainRoundedButton(
            text: Strings.podButton,
            border: Border.all(color: theme.mainTextColor, width: 2),
            color: _selectedCategory == 2 ? theme.mainTextColor : theme.cardColor,
            callback: () {
              _selectedCategory = 2;
              bloc.add(const ShowDisposableProductsEvent());
              setState(() {});
            },
            theme: theme,
            textStyle: theme.fontStyles.regular14.copyWith(
              color: _selectedCategory == 2 ? theme.whiteTextColor : theme.mainTextColor,
            ),
          ),
        ),
        SizedBox(width: adaptiveWidth(5)),
        Expanded(
          flex: 3,
          child: MainRoundedButton(
            text: Strings.snusButton,
            border: Border.all(color: theme.mainTextColor, width: 2),
            color: _selectedCategory == 3 ? theme.mainTextColor : theme.cardColor,
            callback: () {
              _selectedCategory = 3;
              bloc.add(const ShowSnusProductsEvent());
              setState(() {});
            },
            theme: theme,
            textStyle: theme.fontStyles.regular14.copyWith(
              color: _selectedCategory == 3 ? theme.whiteTextColor : theme.mainTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
