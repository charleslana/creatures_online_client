import 'dart:convert';

class RegisterModel {
  RegisterModel({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
    );
  }

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String email;
  String password;
  String passwordConfirmation;

  RegisterModel copyWith({
    String? email,
    String? password,
    String? passwordConfirmation,
  }) {
    return RegisterModel(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }

  String toJson() => json.encode(toMap());
}
