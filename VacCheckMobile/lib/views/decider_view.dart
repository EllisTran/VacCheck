import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vaccheck/model/user_models/business_user_model.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';
import 'package:vaccheck/model/user_models/user_model.dart';
import 'package:vaccheck/views/business_views/business_user_view.dart';
import 'package:vaccheck/views/user_views/personal_user_view.dart';

// Decides between PersonalUser and Business View
class DeciderView extends StatelessWidget {
  final Future user;
  const DeciderView({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? user = snapshot.data as UserModel;
            if (user.userType?['isPersonalUser']) {
              return PersonalUserView(
                user: snapshot.data as PersonalUserModel,
              );
            } else if (user.userType?['isBusiness']) {
              return BusinessUserView(
                user: snapshot.data as BusinessUserModel,
              );
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }
}
