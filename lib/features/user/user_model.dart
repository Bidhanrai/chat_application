import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Timestamp createdAt;

  UserModel({required this.id, required this.email, required this.lastName, required this.firstName, required this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      firstName: json["first name"],
      lastName: json["last name"],
      createdAt: json["created at"],
    );
  }


  Map<String, Object?> toJson() {
    return {
      'email': email,
      'first name': firstName,
      'last name': lastName,
      'created at': createdAt,
    };
  }
}
