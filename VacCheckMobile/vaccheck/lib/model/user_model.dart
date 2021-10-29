class UserModel {
  String? name;
  DateTime? dateOfBirth;
  String? email;
  String? userId;
  Map<String, dynamic>? userType;
  int? numVac;
  String? imageUrl;
  UserModel(this.name, this.email,
      [dateOfBirth, userId, userType, numVac, imageUrl]);

  factory UserModel.userMap(dynamic data) {
    UserModel user = UserModel(data['name'] ?? '', data['email'] ?? '');
    user.dateOfBirth = data['dateOfBirth']?.toDate() ?? DateTime(2000, 1, 1);
    user.numVac = data['numVac'] ?? 0;
    user.userId = data['userId'] ?? '';
    user.userType = data['userType'] ?? {};
    user.imageUrl = data['imageUrl'] ?? "";
    return user;
  }

  factory UserModel.businessMap(dynamic data) {
    UserModel business = UserModel(data['name'] ?? '', data['email'] ?? '');
    business.userId = data['userId'] ?? '';
    business.userType = data['userType'] ?? {};
    return business;
  }
}
