import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import 'package:vaccheck/constants.dart';

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
    return SafeArea(
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Scaffold(
            // appBar: AppBar(
            //   title: Text("Sign Up View"),
            // ),
              body: Form(
                autovalidateMode: AutovalidateMode.always,
                onChanged: () {
                  Form.of(primaryFocus!.context!)!.save();
                },
                key: _formKey,
                child: Column(
                  children: [
                    dateOfBirth == null
                        ? const Text("Pick Birthday")
                        : Text(dateOfBirth!.toString()),
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
                
                Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 134, vertical: 3),
                decoration: BoxDecoration(
                  color: kPrimeColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextButton(
                  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      if (email != null &&
                          password != null &&
                          name != null &&
                          dateOfBirth != null) {
                        PersonalUserModel newUser =
                            PersonalUserModel.initalSignup(
                                name: name!,
                                email: email!,
                                dateOfBirth: dateOfBirth!);
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
              )),
        ],
      ),
    );
  }
}
