import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  AuthController ac = AuthController();

  String? name;
  String? email;
  String? password;
  DateTime? dateOfBirth;
  Map<String, String> address = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up View"),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus!.context!)!.save();
          },
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: (String? value) {
                  // name = value;
                  if (value != null) {
                    name = value;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                onSaved: (String? value) {
                  // name = value;
                  if (value != null) {
                    email = value;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  return (value != null && !value.contains('@'))
                      ? 'Must have be a valid email address'
                      : null;
                },
              ),
              TextFormField(
                onSaved: (String? value) {
                  // name = value;
                  if (value != null) {
                    password = value;
                  }
                },
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'Password',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              Center(
                child: Row(
                  children: [
                    dateOfBirth == null ? const Text("Pick Birthday") : Text(dateOfBirth!.toString()),
                    ElevatedButton(
                      child: const Text("Pick Birthday"),
                      onPressed: () async {
                        final DateTime? dob = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        setState(() {
                          dateOfBirth = dob;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (email != null &&
                          password != null &&
                          name != null &&
                          dateOfBirth != null) {
                        UserModel newUser = UserModel(name!, dateOfBirth!, email!);
                        try {
                          context
                              .read<AuthService>()
                              .signUp(newUser: newUser, password: password!)
                              .then((value) => Navigator.pop(context));
                        } catch (e) {
                          // I need to make an error check for this if the user is already in db
                          print(e);
                        }
                      }
                    }
                  },
                  child: const Text('Sign up!'),
                ),
              ),
            ],
          ),
        ));
  }
}
