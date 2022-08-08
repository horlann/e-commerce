import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:form_validator/form_validator.dart';
import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
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
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminItemBloc bloc = BlocProvider.of<AdminItemBloc>(context);

    return Container(
      height: double.infinity,
      color: theme.backgroundColor,
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: adaptiveWidth(300),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: adaptiveHeight(10)),
                  RoundedInputField(
                    icon: Icons.title,
                    hint: Strings.nameItem,
                    callback: (String callback) => _name = callback,
                    validation: ValidationBuilder()
                        .minLength(5, Strings.min5Characters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                  SizedBox(height: adaptiveHeight(10)),
                  RoundedInputField(
                    icon: Icons.attach_money_rounded,
                    hint: Strings.priceItem,
                    callback: (String callback) => _price = double.tryParse(callback) ?? 0,
                    inputType: TextInputType.number,
                    validation: ValidationBuilder()
                        .minLength(1, Strings.minCharacters)
                        .maxLength(30, Strings.max30Characters)
                        .build(),
                  ),
                  SizedBox(height: adaptiveHeight(10)),
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
                      _selectedCategory.isEmpty ? Strings.selectCategory : _selectedCategory,
                      style: TextStyle(color: theme.mainTextColor, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    controller: _categoryController,
                    theme: ExpandedTileThemeData(
                      headerColor: theme.cardColor,
                      headerRadius: 29.0,
                      contentRadius: 29,
                      contentBackgroundColor: theme.cardColor,
                      contentPadding: const EdgeInsets.all(4),
                    ),
                  ),
                  SizedBox(height: adaptiveHeight(10)),
                  MainRoundedButton(
                    text: Strings.createButton,
                    color: theme.accentColor,
                    textStyle: TextStyle(color: theme.mainTextColor, fontSize: 16, fontWeight: FontWeight.w500),
                    callback: () {
                      if (_formKey.currentState!.validate() && _selectedCategory.isNotEmpty) {}
                    }, // bloc.add(CreateItemEvent)),
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
