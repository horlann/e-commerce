import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/const/const.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';
import 'package:kurilki/presentation/widgets/rounded_text_field.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  String password = "";

  @override
  Widget build(BuildContext context) {
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      title: Text(Strings.enterPassword, style: theme.fontStyles.regular18.copyWith(color: theme.mainTextColor)),
      titlePadding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      content: RoundedInputField(
        callback: (String callback) => password = callback,
      ),
      actions: [
        SizedBox(
          width: 100,
          child: MainRoundedButton(
            text: "OK",
            textStyle: theme.fontStyles.regular14.copyWith(color: theme.whiteTextColor),
            theme: theme,
            color: theme.mainTextColor,
            callback: () {
              if (password == Const.adminPassword) {
                context.pushRoute(const AdminRouter());
              }
              AutoRouter.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
