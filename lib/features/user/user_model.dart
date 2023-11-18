class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({required this.id, required this.email, required this.lastName, required this.firstName});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      firstName: json["first name"],
      lastName: json["last name"],
    );
  }


  Map<String, Object?> toJson() {
    return {
      'email': email,
      'first name': firstName,
      'last name': lastName,
    };
  }
}
