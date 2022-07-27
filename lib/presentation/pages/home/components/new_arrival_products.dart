import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';
import 'package:kurilki/presentation/bloc/products/products_state.dart';
import 'package:kurilki/presentation/pages/home/components/product_card.dart';

import 'section_title.dart';

class NewArrivalProducts extends StatelessWidget {
  const NewArrivalProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "New Arrival",
          pressSeeAll: () {},
        ),
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final List<Item> items = (state as ProductsLoadedState).items;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    items.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        product: items[index],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}