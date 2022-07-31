import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/common/navigation/router.gr.dart';
import 'package:kurilki/presentation/bloc/account/account_bloc.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';
import 'package:kurilki/presentation/pages/account/components/authorized_page.dart';
import 'package:kurilki/presentation/pages/account/components/unauthorized_page.dart';
import 'package:kurilki/presentation/resources/themes/abstract_theme.dart';
import 'package:kurilki/presentation/resources/themes/bloc/themes_bloc.dart';
import 'package:kurilki/presentation/widgets/snackbar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AbstractTheme theme = BlocProvider.of<ThemesBloc>(context).theme;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => context.navigateTo(const AdminRouter()),
          child: Text(
            "Account",
            style: TextStyle(color: theme.whiteTextColor),
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.backgroundColor,
      ),
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AuthorizationFailureState) {
            CustomSnackBar.showSnackNar(context, "Error", "An error occurred during authorization");
          }
        },
        builder: ((context, state) {
          if (state is InProgressAuthState) {
            return Center(child: CircularProgressIndicator(color: theme.accentColor));
          } else if (state is UnauthorizedState) {
            return const UnauthorizedPage();
          } else if (state is AuthorizationFailureState) {
            return const UnauthorizedPage();
          } else if (state is AuthorizedState) {
            return AuthorizedPage(user: state.entity);
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        }),
      ),
    );
  }
}
