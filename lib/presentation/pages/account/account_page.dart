import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';
import 'package:kurilki/presentation/pages/account/components/authorized_page.dart';
import 'package:kurilki/presentation/pages/account/components/unauthorized_page.dart';
import 'package:kurilki/presentation/resources/adaptive_sizes.dart';
import 'package:kurilki/presentation/resources/strings.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AuthorizationFailureState) {
          CustomSnackBar.showSnackNar(context, Strings.warning, Strings.errorDuringAuthorization);
        }
      },
      builder: ((context, state) {
        if (state is InProgressAuthState) {
          return Center(child: CircularProgressIndicator(color: theme.mainTextColor));
        } else if (state is UnauthorizedState) {
          return const UnauthorizedPage();
        } else if (state is AuthorizationFailureState) {
          return const UnauthorizedPage();
        } else if (state is AuthorizedState) {
          return Container(color: theme.backgroundColor, child: AuthorizedPage(user: state.entity));
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      }),
    );
  }
}
