import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/presentation/bloc/admin/admin_bloc.dart';
import 'package:kurilki/presentation/bloc/admin/admin_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class EditDisposableItem extends StatefulWidget {
  const EditDisposableItem({Key? key, required this.item}) : super(key: key);
  final DisposablePodEntity item;

  @override
  State<EditDisposableItem> createState() => _EditDisposableItemState();
}

class _EditDisposableItemState extends State<EditDisposableItem> {
  int puffsCount = 0;

  @override
  void initState() {
    super.initState();
    puffsCount = widget.item.puffsCount;
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
              "Puffs: ",
              style: TextStyle(color: theme.infoTextColor, fontSize: 16),
            ),
          ],
        ),
        RoundedInputField(
          inputType: TextInputType.number,
          hint: puffsCount.toString(),
          callback: (String callback) => puffsCount = int.tryParse(callback) ?? puffsCount,
        ),
        SizedBox(height: scale * 10),
        MainRoundedButton(
          text: "Update item",
          color: theme.accentColor,
          textStyle: TextStyle(color: theme.infoTextColor, fontSize: 16, fontWeight: FontWeight.w500),
          callback: () {
            bloc.add(  
              UpdateDisposableItemEvent(widget.item.copyWith(puffsCount: puffsCount)),
            );
          },
          theme: theme,
        ),
      ],
    );
  }
}
