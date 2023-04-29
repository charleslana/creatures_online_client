import 'package:creatures_online_client/enums/character_type.dart';

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });

  final int id;
  final String name;
  final String image;
  final CharacterType type;
}
