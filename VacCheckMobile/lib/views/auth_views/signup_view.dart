import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/src/provider.dart';
import 'package:vaccheck/controller/auth_controller.dart';
import 'package:vaccheck/firebase/auth_service.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import 'package:vaccheck/constants.dart';
import 'package:intl/intl.dart';

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
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
        
        appBar: AppBar(
          titleSpacing: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: kWhiteColor,
          foregroundColor: kPrimeColor,
          elevation: 0,
          title: const Text("Sign Up",
          style: TextStyle(
            color: kPrimeColor,
            fontFamily: 'SF',
            fontSize: 22,
            fontWeight: FontWeight.w200,
          ),
        ),  
      ),
      body: Form(
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        Form.of(primaryFocus!.context!)!.save();
      },
      key: _formKey,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backgroundScreenSignup.png"),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                SizedBox(height: size.height * 0.01),



                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 20),
                  child: TextFormField(
                
                    onSaved: (String? value) {
                      // name = value;
                      if (value != null) {
                        name = value;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person,size: 25,),
                      labelText: 'Name',
                      fillColor: Colors.white, 
                      hintStyle: TextStyle(
                        color: kTextColor, 
                        fontFamily: "SF"
                      ),
                     
                      
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),



                SizedBox(height: size.height * 0.03),




                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 20,),
                  child: TextFormField(
                    onSaved: (String? value) {
                      // name = value;
                      if (value != null) {
                        email = value;
                      }
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      ),
                      icon: Icon(Icons.email,size: 25,),
                      labelText: 'Email',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      return (value != null && !value.contains('@'))
                          ? 'Must have be a valid email address'
                          : null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 7, right: 20),
                  child: TextFormField(
                    onSaved: (String? value) {
                      // name = value;
                      if (value != null) {
                        password = value;
                      }
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      ),
                      icon: Icon(Icons.password,size: 25,),
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
                ), 
                SizedBox(height: size.height * 0.04),              
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          primary: kPrimeColor, // background
                          onPrimary: Colors.white, // foreground
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)))),
                          child: const Text("Pick Birthday",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontFamily: "SF",
                              fontSize: 14,
                            ),
                          ),
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
                      ),
                      const Spacer(),
                      dateOfBirth == null
                          ? const Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Text("Pick Birthday",
                            style: TextStyle(
                                color: kTextColor,
                                // fontWeight: FontWeight.w400,
                                fontFamily: 'SF',
                                fontSize: 16)
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Text(DateFormat.yMMMMd('en_US').format(dateOfBirth!).toString(),
                            style: const TextStyle(
                                color: kPrimeColor,
                                // fontWeight: FontWeight.w400,
                                fontFamily: 'SF',
                                fontSize: 16)
                            ),
                          ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.2),

                SizedBox(
                  width: size.width * 0.85,
                  height: size.height * 0.0657,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        splashFactory: NoSplash.splashFactory,
                        primary: kPrimeColor, // background
                        onPrimary: Colors.white, // foreground
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(29)))),
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
                      }
                    },
                    child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: kWhiteColor,
                          fontFamily: "SF",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ),
                  
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       if (_formKey.currentState!.validate()) {
                //         if (email != null &&
                //             password != null &&
                //             name != null &&
                //             dateOfBirth != null) {
                //           PersonalUserModel newUser =
                //               PersonalUserModel.initalSignup(
                //                   name: name!,
                //                   email: email!,
                //                   dateOfBirth: dateOfBirth!);
                //           try {
                //             context
                //                 .read<AuthService>()
                //                 .signUp(newUser: newUser, password: password!)
                //                 .then((value) => Navigator.pop(context));
                //           } catch (e) {
                //             // I need to make an error check for this if the user is already in db
                //             print(e);
                //           }
                //         }
                //       }
                //     },
                //     child: const Text('Sign up!'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
