import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/views/auth_views/login_view.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fbUser = context.watch<User?>();
    if (fbUser != null) {
      return Column(children: [
        const Text("Signed in"),
        TextButton(
          onPressed: () {
            context.read<AuthService>().signOut();
          },
          child: const Text("Sign out"),
        )
      ]);
    }
    return const LoginView();
  }
}
