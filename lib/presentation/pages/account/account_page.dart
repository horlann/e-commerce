import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/presentation/bloc/auth/auth_bloc.dart';
import 'package:kurilki/presentation/bloc/auth/auth_event.dart';
import 'package:kurilki/presentation/bloc/auth/auth_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AuthBloc();
    /* return StreamBuilder(
      stream: bloc.stream,
      builder: ((context, snapshot) {if(snapshot.hasData)}),
    );*/
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is UnauthorizedState) {
          return Center(
            child: ElevatedButton(
              onPressed: () => bloc.add(AuthWithGoogleAccountEvent()),
              child: const Text("Sign Up with Google"),
            ),
          );
        } else if (state is AuthorizedState) {
          return Container(color: Colors.red, height: 100, width: 100);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
