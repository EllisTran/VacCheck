import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vaccheck/model/user_model.dart';
import 'package:vaccheck/views/business_views/business_view.dart';
import 'package:vaccheck/views/user_views/user_view.dart';

// Decides between User and Business View
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
              return UserView(
                user: user,
              );
            } else if (user.userType?['isBusiness']) {
              return BusinessView(
                user: user,
              );
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }
}
