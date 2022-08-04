import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_state.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/admin_products_list.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Список продуктов",
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.accentColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: Container(
        height: double.infinity,
        color: theme.backgroundColor,
        child: BlocConsumer<AdminItemBloc, AdminItemState>(
          listener: (context, state) {
            if (state is SaveEditItemState) {
              CustomSnackBar.showSnackNar(context, "Info", "Item was updated");
            }
          },
          builder: ((context, state) {
            if (state is InProgressLoadingState) {
              return Center(child: CircularProgressIndicator(color: theme.accentColor));
            } else if (state is ItemsLoadedState) {
              return ProductsList(items: state.items);
            } else {
              return const Text("Something went wrong");
            }
          }),
        ),
      ),
    );
  }
}
