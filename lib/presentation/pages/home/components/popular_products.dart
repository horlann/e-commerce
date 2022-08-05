import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/item_settings.dart';
import 'package:kurilki/domain/entities/items/popular_item.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_state.dart';
import 'package:kurilki/presentation/pages/home/components/popular_product_card.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  bool isPopularExpanded = false;

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Padding(
      padding: EdgeInsets.all(adaptiveWidth(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.popular,
            style: theme.fontStyles.semiBold18.copyWith(color: theme.infoTextColor),
          ),
          SizedBox(height: adaptiveHeight(10)),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductsLoadedState) {
                final List<Item> items = state.popularItems.reversed.toList();
                final List<PopularItem> popularItems = [];
                for (Item item in items) {
                  for (ItemSettings itemSettings in item.itemSettings) {
                    if (itemSettings.isPopular) {
                      popularItems.add(PopularItem(item: item, itemSettings: itemSettings));
                    }
                  }
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      popularItems.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: adaptiveWidth(16)),
                          child: PopularProductCard(
                            item: popularItems[index].item,
                            itemSettings: popularItems[index].itemSettings,
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
