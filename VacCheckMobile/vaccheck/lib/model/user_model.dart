class UserModel {
  String? name;
  DateTime? dateOfBirth;
  String? email;
  String? userId;
  Map<String, dynamic>? userType;
  int? numVac;
  UserModel(this.name, this.dateOfBirth, this.email,
      [userId, userType, numVac]);
  String generateUniqueCode() {
    String genCode = "${numVac}${name}+${userId}${DateTime.now()}";
    return genCode;
  }

  factory UserModel.fromMap(dynamic data) {
    print(data['numVac']);
    UserModel user = UserModel(
        data['name'] ?? '',
        data['dateOfBirth']?.toDate() ?? DateTime(2000, 1, 1),
        data['email'] ?? '');
    user.numVac = data['numVac'] ?? 0;
    user.userId = data['userId'] ?? '';
    user.userType = data['userType'] ?? {};
    return user;
  }
}
