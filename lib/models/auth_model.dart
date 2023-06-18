import 'dart:convert';

class AuthModel {
  AuthModel({
    required this.email,
    required this.password,
  });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String email;
  String password;

  AuthModel copyWith({
    String? email,
    String? password,
  }) {
    return AuthModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
