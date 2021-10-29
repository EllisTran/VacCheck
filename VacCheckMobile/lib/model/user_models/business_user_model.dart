
import 'package:vaccheck/model/user_models/user_model.dart';

class BusinessUserModel extends UserModel {
  String userId;
  // Other fields I will use later

  BusinessUserModel({
    required name,
    required email,
    required userType,
    required this.userId,
  }) : super(name: name, email: email, userType: userType);

  factory BusinessUserModel.businessMap(dynamic data) {
    BusinessUserModel businessUserModel = BusinessUserModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        userType: data['userType'] ?? {},
        userId: data['userId'] ?? '');
    return businessUserModel;
  }
}
