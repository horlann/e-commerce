import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kurilki/domain/entities/category_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class CreateItem extends StatefulWidget {
  final List<CategoryEntity> categories;

  const CreateItem({Key? key, required this.categories}) : super(key: key);

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  String _name = "";
  double _price = 0;
  String _selectedCategory = "";
  final ExpandedTileController _categoryController = ExpandedTileController();

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final scale = byWithScale(context);

    return Column(children: [
      SizedBox(height: scale * 10),
      RoundedInputField(hint: "Name", callback: (String callback) => _name = callback),
      SizedBox(height: scale * 10),
      RoundedInputField(
        hint: "Price",
        callback: (String callback) => _price = double.parse(callback),
        inputType: TextInputType.number,
      ),
      SizedBox(height: scale * 10),
      ExpandedTile(
        content: ListView.builder(
          itemBuilder: ((context, index) {
            return ListTile(
              title: AutoSizeText(
                widget.categories[index].name,
                style: TextStyle(
                  color: theme.whiteTextColor,
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
          style: TextStyle(color: theme.whiteTextColor, fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        controller: _categoryController,
        theme: ExpandedTileThemeData(
          headerColor: theme.accentColor,
          headerRadius: 29.0,
          contentBackgroundColor: theme.accentColor,
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
      MainRoundedButton(
        text: "Create item",
        color: theme.accentColor,
        callback: () {}, // bloc.add(const AddNewItemEvent()),
        theme: theme,
      ),
    ]);
  }
}
