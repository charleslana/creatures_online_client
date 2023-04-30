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

  int id;
  int level;
  int hpMin;
  int hpMax;
  int slot;
  final CharacterModel character;
}
