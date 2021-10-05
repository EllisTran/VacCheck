import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/firebase/auth_service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Authentication'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthService>().signIn();
            },
            child: Text("Sign in"),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthService>().signUp();
            },
            child: Text("Sign Up"),
          )
        ],
      ),
    );
  }
}
