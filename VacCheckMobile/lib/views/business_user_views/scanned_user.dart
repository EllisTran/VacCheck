// Honestly this is def not good practice i feel like but who tf cares anymore LOL

import 'package:flutter/material.dart';
import 'package:vaccheck/model/user_models/personal_user_model.dart';

class ScannedUser extends StatelessWidget {
  final Future user;
  const ScannedUser({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PersonalUserModel? user = snapshot.data as PersonalUserModel;
            if (snapshot.hasData) {
              if (user.imageUrl != null) {
                return Image.network(user.imageUrl!, fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                });
                // Container(
                //     width: 100.0,
                //     height: 100.0,
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         image: DecorationImage(
                //             fit: BoxFit.fill,
                //             image: NetworkImage(user.imageUrl!))));
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
