import 'package:intl/intl.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String photo;
  final String maritalStatus;
  final String joinedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.photo,
    required this.maritalStatus,
    required this.joinedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        photo: json['photo'],
        maritalStatus: json['marital_status'],
        joinedAt: DateFormat('MM/dd/yyyy').format(DateTime.parse(json['joinedAt'])),
      );
}
