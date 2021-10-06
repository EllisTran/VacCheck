class UserModel {
  String name;
  DateTime dateOfBirth;
  String email;
  String ssn;
  Map<String, String> address;

  UserModel(this.name, this.dateOfBirth, this.email, this.ssn, this.address);
}
