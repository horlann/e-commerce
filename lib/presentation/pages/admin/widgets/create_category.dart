import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key, required this.categories}) : super(key: key);
  final List<CategoryEntity> categories;
  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  String _category = "";

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final scale = byWithScale(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: scale * 10),
        RoundedInputField(
          hint: "Category ",
          callback: (String callback) => _category = callback,
        ),
        SizedBox(height: scale * 10),
        MainRoundedButton(
          text: "Create category",
          color: theme.accentColor,
          callback: () {
            if (_category.isNotEmpty) {
              bloc
                ..add(AddNewCategoryEvent(_category))
                ..add(const InitDataEvent());
            }
          },
          theme: theme,
        ),
      ],
    );
  }
}
