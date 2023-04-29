import 'package:creatures_online_client/models/character_model.dart';

class UserCharacterModel {
  UserCharacterModel({
    required this.level,
    required this.hpMin,
    required this.hpMax,
    required this.character,
  });

  final int level;
  final int hpMin;
  final int hpMax;
  final CharacterModel character;
}
