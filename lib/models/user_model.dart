import 'package:creatures_online_client/models/user_character_model.dart';

class UserModel {
  UserModel({
    required this.email,
    required this.password,
    this.name,
    this.characters,
  });

  String email;
  String password;
  String? name;
  List<UserCharacterModel>? characters;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
      "characters": characters,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      name: json["name"],
      characters: UserCharacterModel.listFromJson(json['characters']),
    );
  }

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    List<UserCharacterModel>? characters,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      characters: characters ?? this.characters,
    );
  }
}
