import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class DataLoaded extends StatefulWidget {
  const DataLoaded({Key? key, required this.categories}) : super(key: key);
  final List<CategoryEntity> categories;

  @override
  State<DataLoaded> createState() => _DataLoadedState();
}

class _DataLoadedState extends State<DataLoaded> {
  final _formKey = GlobalKey<FormState>();
  String _category = "";

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final scale = byWithScale(context);

    return Container(
      color: theme.backgroundColor,
      child: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: scale * 200,
            child: Column(
              children: [
                SizedBox(height: scale * 10),
                RoundedInputField(
                  hint: "Category ",
                  callback: (String callback) => _category = callback,
                  validation: ValidationBuilder()
                      .minLength(1, Strings.minCharacters)
                      .maxLength(20, Strings.max20Characters)
                      .build(),
                ),
                SizedBox(height: scale * 10),
                MainRoundedButton(
                  text: "Create category",
                  color: theme.accentColor,
                  textStyle: TextStyle(color: theme.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                  callback: () {
                    if (_formKey.currentState!.validate() && _category.isNotEmpty) {
                      bloc
                        ..add(AddNewCategoryEvent(_category))
                        ..add(const InitCategoriesEvent());
                    }
                  },
                  theme: theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
