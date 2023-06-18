import 'dart:convert';

import 'package:creatures_online_client/models/character_model.dart';

class UserCharacterModel {
  UserCharacterModel({
    required this.id,
    required this.level,
    required this.hpMin,
    required this.hpMax,
    required this.slot,
    required this.character,
  });

  factory UserCharacterModel.fromJson(Map<String, dynamic> json) {
    return UserCharacterModel(
      id: json['id'],
      level: json['level'],
      hpMin: json['hpMin'],
      hpMax: json['hpMax'],
      slot: json['slot'],
      character: CharacterModel.fromJson(json['character']),
    );
  }

  int id;
  int level;
  int hpMin;
  int hpMax;
  int slot;
  final CharacterModel character;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'hpMin': hpMin,
      'hpMax': hpMax,
      'slot': slot,
      'character': character,
    };
  }

  static List<UserCharacterModel> listFromJson(dynamic list) =>
      List<UserCharacterModel>.from(list.map(UserCharacterModel.fromJson));

  static String modelToJson(List<UserCharacterModel> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
