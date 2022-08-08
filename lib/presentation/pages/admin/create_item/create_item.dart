import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/category/admin_category_state.dart';
import 'package:kurilki/presentation/pages/admin/create_item/components/data_loaded.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

class CreateItem extends StatelessWidget {
  const CreateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Strings.createProducts,
          style: TextStyle(color: theme.mainTextColor),
        ),
        foregroundColor: theme.mainTextColor,
        backgroundColor: theme.backgroundColor,
      ),
      body: BlocBuilder<AdminCategoryBloc, AdminCategoryState>(
        builder: ((context, state) {
          if (state is InProgressLoadingState) {
            return Center(child: CircularProgressIndicator(color: theme.accentColor));
          } else if (state is CategoriesLoadedState) {
            return DataLoaded(categories: state.categories);
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        }),
      ),
    );
  }
}
