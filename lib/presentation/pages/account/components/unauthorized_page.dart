import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';

import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AccountBloc>(context);
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      color: theme.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: adaptiveWidth(16)),
              child: Text(
                Strings.connectToAccount,
                textAlign: TextAlign.center,
                style: theme.fontStyles.regular20.copyWith(color: theme.mainTextColor),
              ),
            ),
            SizedBox(height: adaptiveHeight(10)),
            SizedBox(
              width: adaptiveWidth(250),
              child: MainRoundedButton(
                text: Strings.loginWithGoogle,
                color: theme.mainTextColor,
                theme: theme,
                callback: () => bloc.add(
                  const AuthWithGoogleAccountEvent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
