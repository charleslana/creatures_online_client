class UserModel {
  UserModel({
    required this.email,
    required this.password,
    this.name,
  });

  String email;
  String password;
  String? name;

  Map<String, dynamic> toJson() {
    return {
      "email": email.trim(),
      "password": password.trim(),
      "name": name?.trim(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      name: json["name"],
    );
  }

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }
}
