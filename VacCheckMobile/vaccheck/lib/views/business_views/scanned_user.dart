// Honestly this is def not good practice i feel like but who tf cares anymore LOL

import 'package:flutter/material.dart';
import 'package:vaccheck/model/user_model.dart';

class ScannedUser extends StatelessWidget {
  final Future user;
  const ScannedUser({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? user = snapshot.data as UserModel;
            if (snapshot.hasData) {
              if (user.imageUrl != null) {
                return Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(user.imageUrl!))));
              }
            } else {
              return const Text("No picture");
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }
}
