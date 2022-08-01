import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class DataLoaded extends StatefulWidget {
  final List<CategoryEntity> categories;
  const DataLoaded({Key? key, required this.categories}) : super(key: key);

  @override
  State<DataLoaded> createState() => _DataLoadedState();
}

class _DataLoadedState extends State<DataLoaded> {
  final _formKey = GlobalKey<FormState>();
  final ExpandedTileController _categoryController = ExpandedTileController();
  String _name = "";
  double _price = 0;
  String _selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    final scale = byWithScale(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);

    return Container(
      height: double.infinity,
      color: theme.backgroundColor,
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: scale * 200,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: scale * 10),
                  RoundedInputField(
                    hint: "Name",
                    callback: (String callback) => _name = callback,
                    validation: ValidationBuilder()
                        .minLength(5, Strings.min5Characters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                  SizedBox(height: scale * 10),
                  RoundedInputField(
                    hint: "Price",
                    callback: (String callback) => _price = double.tryParse(callback) ?? 0,
                    inputType: TextInputType.number,
                    validation: ValidationBuilder()
                        .minLength(1, Strings.minCharacters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                  SizedBox(height: scale * 10),
                  ExpandedTile(
                    content: ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: AutoSizeText(
                            widget.categories[index].name,
                            style: TextStyle(
                              color: theme.mainTextColor,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            _selectedCategory = widget.categories[index].name;
                            _categoryController.collapse();
                            setState(() {});
                          },
                        );
                      }),
                      itemCount: widget.categories.length,
                      shrinkWrap: true,
                    ),
                    title: AutoSizeText(
                      _selectedCategory.isEmpty ? "Select category" : _selectedCategory,
                      style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    controller: _categoryController,
                    theme: ExpandedTileThemeData(
                      headerColor: theme.cardColor,
                      headerRadius: 29.0,
                      contentBackgroundColor: theme.cardColor,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                  ),
                  SizedBox(height: scale * 5),
                  MainRoundedButton(
                    text: "Create item",
                    color: theme.accentColor,
                    textStyle: TextStyle(color: theme.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                    callback: () {
                      if (_formKey.currentState!.validate() && _selectedCategory.isNotEmpty) {}
                    }, // bloc.AddNewItemEvent()),
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
