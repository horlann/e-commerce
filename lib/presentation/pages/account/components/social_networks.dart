import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/resources/icons.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/circle_icon_button.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class SocialNetworks extends StatelessWidget {
  const SocialNetworks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          color: theme.whiteTextColor,
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIconButton(icon: CustomIcons.instagram, callback: () {}, theme: theme),
            CircleIconButton(icon: CustomIcons.telegram, callback: () {}, theme: theme),
            CircleIconButton(icon: CustomIcons.facebook, callback: () {}, theme: theme),
            SizedBox(
              width: 96,
              height: 48,
              child: MainRoundedButton(
                  //TODO: Кнопку перемістити
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
