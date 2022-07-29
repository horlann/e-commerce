import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';

import 'create_category.dart';
import 'create_item.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key, required this.categories}) : super(key: key);
  final List<CategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final scale = byWithScale(context);

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: scale * 200,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateCategory(categories: categories),
                SizedBox(width: scale * 20),
                CreateItem(categories: bloc.categories),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
