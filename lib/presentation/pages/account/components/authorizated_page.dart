import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';

import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/image_provider.dart';

class AuthorizatedPage extends StatelessWidget {
  const AuthorizatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AccountBloc();
    final firebase = FirebaseAuth.instance;
    final AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Container(
      color: theme.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CustomImageProvider(
                imageLink: firebase.currentUser?.photoURL ?? "", //photo
                imageFrom: ImageFrom.network,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Center(
              child: AutoSizeText(
                firebase.currentUser?.displayName ?? "Google account",
                minFontSize: 12,
                maxFontSize: 20,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //bloc.add(LogoutFromAccountEvent()),
}
