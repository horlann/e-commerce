import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/main_rounded_button.dart';

class UnauthorizatedPage extends StatelessWidget {
  const UnauthorizatedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AccountBloc();
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          child: Text(
            "Connect your account to make purchase easier",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 200,
          child: MainRoundedButton(
            text: "Login with Google",
            color: theme.accentColor,
            theme: theme,
            callback: () => bloc.add(
              AuthWithGoogleAccountEvent(),
            ),
          ),
        ),
      ]),
    );
  }
}
