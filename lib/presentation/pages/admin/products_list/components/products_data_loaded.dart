import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/item_card.dart';

class ProductsDataLoaded extends StatelessWidget {
  const ProductsDataLoaded({Key? key, required this.items}) : super(key: key);
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemCard(item: items[index]);
      },
    );
  }
}
