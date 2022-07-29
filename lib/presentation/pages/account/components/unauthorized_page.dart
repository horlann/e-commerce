import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/resources/size_utils.dart';
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
    final scale = byWithScale(context);

    return Container(
      color: theme.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              child: Text(
                "Connect your account to make purchases easier",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(height: scale * 10),
            SizedBox(
              width: scale * 200,
              child: MainRoundedButton(
                text: "Login with Google",
                textStyle: TextStyle(color: theme.infoTextColor, fontWeight: FontWeight.w600, fontSize: 18),
                color: theme.accentColor,
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
