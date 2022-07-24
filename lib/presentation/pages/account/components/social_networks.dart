import 'package:flutter/material.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/widgets/circle_icon_button.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class SocialNetworks extends StatelessWidget {
  const SocialNetworks({
    Key? key,
    required this.theme,
    required this.bloc,
  }) : super(key: key);

  final AbstractTheme theme;
  final AccountBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: theme.whiteTextColor,
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIconButton(icon: CustomIcons.instagram, callback: () {}, theme: theme),
            CircleIconButton(icon: CustomIcons.telegram, callback: () {}, theme: theme),
            SizedBox(
              width: 96,
              height: 48,
              child: MainRoundedButton(
                  // Кнопку перемістити
                  text: "Logout",
                  color: theme.accentColor,
                  callback: () => bloc.add(LogoutFromAccountEvent()),
                  theme: theme),
            ),
          ],
        ),
      ),
    );
  }
}
