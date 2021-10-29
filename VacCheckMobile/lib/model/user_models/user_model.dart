class UserModel {
  String name;
  String email;
  Map<String, dynamic>? userType;
  UserModel({required this.name, required this.email, this.userType});

  factory UserModel.userMap(dynamic data) {
    return UserModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        userType: data['userType'] ?? {});
  }
}
