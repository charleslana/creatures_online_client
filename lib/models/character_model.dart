import 'package:creatures_online_client/enums/character_type.dart';

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      type: CharacterType.fromJson(json['type']),
    );
  }

  final int id;
  final String name;
  final CharacterType type;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}
