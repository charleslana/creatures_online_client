import 'package:creatures_online_client/enums/character_type.dart';

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.type,
  });

  final int id;
  final String name;
  final CharacterType type;
}
