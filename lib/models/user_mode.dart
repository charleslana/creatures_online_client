class UserModel {
  UserModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  Map<String, dynamic> toJson() {
    return {
      "email": email.trim(),
      "password": password.trim(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
    );
  }
}
