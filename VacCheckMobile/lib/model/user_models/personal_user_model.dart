
import 'package:vaccheck/model/user_models/user_model.dart';

class PersonalUserModel extends UserModel {
  DateTime dateOfBirth;
  int? numVac;
  String? userId;
  String? imageUrl;
  PersonalUserModel(
      {required String name,
      required String email,
      required Map<String, dynamic> userType,
      required this.dateOfBirth,
      required this.numVac,
      required this.userId,
      required this.imageUrl})
      : super(name: name, email: email, userType: userType);

  PersonalUserModel.initalSignup(
      {required String name, required String email, required this.dateOfBirth})
      : super(name: name, email: email);

  factory PersonalUserModel.personalUserMap(dynamic data) {
    // PersonalUserModel user = PersonalUserModel(data['name'] ?? '', data['email'] ?? '');
    PersonalUserModel user = PersonalUserModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        userType: data['userType'] ?? '',
        dateOfBirth: data['dateOfBirth']?.toDate() ?? DateTime(2000, 1, 1),
        numVac: data['numVac'] ?? 0,
        userId: data['userId'] ?? '',
        imageUrl: data['imageUrl'] ?? '');
    return user;
  }
}
