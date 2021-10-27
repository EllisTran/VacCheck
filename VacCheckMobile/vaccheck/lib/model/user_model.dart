class UserModel {
  String? name;
  DateTime? dateOfBirth;
  String? email;
  String? userId;
  Map<String, dynamic>? userType;
  int? numVac;
  UserModel(this.name, this.email, [dateOfBirth, userId, userType, numVac]);
  String generateUniqueCode() {
    String genCode = "${numVac}${name}+${userId}${DateTime.now()}";
    return genCode;
  }

  factory UserModel.UserMap(dynamic data) {
    UserModel user = UserModel(data['name'] ?? '', data['email'] ?? '');
    user.dateOfBirth = data['dateOfBirth']?.toDate() ?? DateTime(2000, 1, 1);
    user.numVac = data['numVac'] ?? 0;
    user.userId = data['userId'] ?? '';
    user.userType = data['userType'] ?? {};
    return user;
  }

  factory UserModel.BusinessMap(dynamic data) {
    UserModel business = UserModel(data['name'] ?? '', data['email'] ?? '');
    business.userId = data['userId'] ?? '';
    business.userType = data['userType'] ?? {};
    return business;
  }
}
