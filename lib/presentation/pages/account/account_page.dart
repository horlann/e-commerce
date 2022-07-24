import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kurilki/presentation/pages/account/components/authorizated_page.dart';
import 'package:kurilki/presentation/pages/account/components/unauthorizated_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const AuthorizatedPage();
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        } else {
          return const UnauthorizatedPage();
        }
      }),
    );
  }
}
