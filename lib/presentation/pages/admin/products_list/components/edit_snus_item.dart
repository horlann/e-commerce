import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class EditSnusItem extends StatefulWidget {
  const EditSnusItem({Key? key, required this.item}) : super(key: key);
  final Snus item;

  @override
  State<EditSnusItem> createState() => _EditSnusItemState();
}

class _EditSnusItemState extends State<EditSnusItem> {
  int strength = 0;

  @override
  void initState() {
    super.initState();
    strength = widget.item.strength;
  }

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    final AdminBloc bloc = BlocProvider.of<AdminBloc>(context);
    final scale = byWithScale(context);

    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: scale * 20),
            Text(
              "Strength: ",
              style: TextStyle(color: theme.infoTextColor, fontSize: 16),
            ),
          ],
        ),
        RoundedInputField(
            inputType: TextInputType.number,
            hint: strength.toString(),
            callback: (String callback) {
              try {
                strength = int.parse(callback);
              } on FormatException catch (e) {}
            }),
        SizedBox(height: scale * 10),
        MainRoundedButton(
          text: "Update item",
          color: theme.accentColor,
          textStyle: TextStyle(color: theme.infoTextColor, fontSize: 16, fontWeight: FontWeight.w500),
          callback: () {
            bloc.add(UpdateSnusItemEvent(widget.item.copyWith(strength: strength)));
          },
          theme: theme,
        ),
      ],
    );
  }
}
