import 'dart:convert';

import 'package:creatures_online_client/models/character_model.dart';

class UserCharacterModel {
  UserCharacterModel({
    required this.id,
    required this.experience,
    required this.level,
    required this.upgrade,
    required this.minHp,
    required this.maxHp,
    this.slot,
    required this.userId,
    required this.characterId,
    required this.createdAt,
    required this.updatedAt,
    required this.character,
  });

  factory UserCharacterModel.fromMap(Map<String, dynamic> map) {
    return UserCharacterModel(
      id: map['id'] as String,
      experience: map['experience'] as String,
      level: map['level'] as int,
      upgrade: map['upgrade'] as int,
      minHp: map['minHp'] as int,
      maxHp: map['maxHp'] as int,
      slot: map['slot'] != null ? map['slot'] as int : null,
      userId: map['userId'] as String,
      characterId: map['characterId'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      character:
          CharacterModel.fromMap(map['character'] as Map<String, dynamic>),
    );
  }

  factory UserCharacterModel.fromJson(String source) =>
      UserCharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String id;
  String experience;
  int level;
  int upgrade;
  int minHp;
  int maxHp;
  int? slot;
  String userId;
  String characterId;
  String createdAt;
  String updatedAt;
  CharacterModel character;

  UserCharacterModel copyWith({
    String? id,
    String? experience,
    int? level,
    int? upgrade,
    int? minHp,
    int? maxHp,
    int? slot,
    String? userId,
    String? characterId,
    String? createdAt,
    String? updatedAt,
    CharacterModel? character,
  }) {
    return UserCharacterModel(
      id: id ?? this.id,
      experience: experience ?? this.experience,
      level: level ?? this.level,
      upgrade: upgrade ?? this.upgrade,
      minHp: minHp ?? this.minHp,
      maxHp: maxHp ?? this.maxHp,
      slot: slot ?? this.slot,
      userId: userId ?? this.userId,
      characterId: characterId ?? this.characterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      character: character ?? this.character,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'experience': experience,
      'level': level,
      'upgrade': upgrade,
      'minHp': minHp,
      'maxHp': maxHp,
      'slot': slot,
      'userId': userId,
      'characterId': characterId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'character': character.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  static List<UserCharacterModel> listFromJson(dynamic source) {
    final list = List<dynamic>.from(source);
    return List<UserCharacterModel>.from(
        list.map((x) => UserCharacterModel.fromMap(x)));
  }
}
