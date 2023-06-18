import 'dart:convert';

import 'package:creatures_online_client/models/user_character_model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.banned,
    required this.gold,
    required this.shard,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    this.characters,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      banned: map['banned'] != null ? map['banned'] as String : null,
      gold: map['gold'] as String,
      shard: map['shard'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      roles: List<UserRole>.from(
        (map['roles'] as List<dynamic>).map<UserRole>(
          (x) => UserRole.fromMap(x as Map<String, dynamic>),
        ),
      ),
      characters: map['characters'] != null
          ? List<UserCharacterModel>.from(
              (map['characters'] as List<dynamic>).map<UserCharacterModel?>(
                (x) => UserCharacterModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String id;
  String email;
  String? name;
  String? banned;
  String gold;
  String shard;
  String createdAt;
  String updatedAt;
  List<UserRole> roles;
  List<UserCharacterModel>? characters;

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? banned,
    String? gold,
    String? shard,
    String? createdAt,
    String? updatedAt,
    List<UserRole>? roles,
    List<UserCharacterModel>? characters,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      banned: banned ?? this.banned,
      gold: gold ?? this.gold,
      shard: shard ?? this.shard,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roles: roles ?? this.roles,
      characters: characters ?? this.characters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'banned': banned,
      'gold': gold,
      'shard': shard,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'roles': roles.map((x) => x.toMap()).toList(),
      'characters': characters?.map((x) => x.toJson()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class UserRole {
  UserRole({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserRole.fromMap(Map<String, dynamic> map) {
    return UserRole(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['userId'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  factory UserRole.fromJson(String source) =>
      UserRole.fromMap(json.decode(source) as Map<String, dynamic>);

  String id;
  String name;
  String userId;
  String createdAt;
  String updatedAt;

  UserRole copyWith({
    String? id,
    String? name,
    String? userId,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserRole(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());
}
