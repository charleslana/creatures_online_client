import 'package:creatures_online_client/enums/character_type.dart';

class CharacterModel {
  CharacterModel.name({
    required this.name,
    required this.image,
    required this.level,
    required this.type,
    required this.hpMin,
    required this.hpMax,
  });

  final String name;
  final String image;
  final int level;
  final CharacterType type;
  final int hpMin;
  final int hpMax;
}
