import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_state.dart';
import 'package:kurilki/presentation/pages/admin/products_list/components/products_data_loaded.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Products list", style: TextStyle(color: theme.mainTextColor)),
        foregroundColor: theme.accentColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: Container(
        height: double.infinity,
        color: theme.backgroundColor,
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: ((context, state) {
            if (state is InProgressLoadingState) {
              return Center(child: CircularProgressIndicator(color: theme.accentColor));
            } else if (state is ProductsLoadedState) {
              return ProductsDataLoaded(items: state.products);
            } else {
              return const Text("Something went wrong");
            }
          }),
        ),
      ),
    );
  }
}
