import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/views/login_page.dart';
import './firebase/firebase_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // For local storage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseWrapper fb = FirebaseWrapper();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService?>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthenticationWrapper(key: null),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fbUser = context.watch<User?>();
    // ignore: unnecessary_null_comparison
    if (fbUser != null) {
      return Column(children: [
        Text("Signed in"),
        TextButton(
          onPressed: () {
            print("Sign out");
            context.read<AuthService>().signOut();
          },
          child: Text("Sign out"),
        )
      ]);
      // return const Text("Signed In");
    }
    // else {
    return LoginPage();
    // }
  }
}
