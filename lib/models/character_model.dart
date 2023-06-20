import 'dart:convert';

import 'package:creatures_online_client/enums/character_class_enum.dart';
import 'package:creatures_online_client/enums/rarity_enum.dart';

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.characterClass,
    required this.hp,
    required this.furyHit,
    required this.furyDefense,
    this.attack,
    this.magicAttack,
    this.defense,
    this.magicDefense,
    required this.agility,
    this.critical,
    this.dodge,
    required this.rarity,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] as String,
      name: map['name'] as String,
      characterClass: CharacterClassEnum.fromJson(map['characterClass']),
      hp: map['hp'] as int,
      furyHit: map['furyHit'] as int,
      furyDefense: map['furyDefense'] as int,
      attack: map['attack'] != null ? map['attack'] as int : null,
      magicAttack:
          map['magicAttack'] != null ? map['magicAttack'] as int : null,
      defense: map['defense'] != null ? map['defense'] as int : null,
      magicDefense:
          map['magicDefense'] != null ? map['magicDefense'] as int : null,
      agility: map['agility'] as int,
      critical: map['critical'] != null ? map['critical'] as double : null,
      dodge: map['dodge'] != null ? map['dodge'] as double : null,
      rarity: RarityEnum.fromJson(map['rarity']),
    );
  }

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String id;
  String name;
  CharacterClassEnum characterClass;
  int hp;
  int furyHit;
  int furyDefense;
  int? attack;
  int? magicAttack;
  int? defense;
  int? magicDefense;
  int agility;
  double? critical;
  double? dodge;
  RarityEnum rarity;

  CharacterModel copyWith({
    String? id,
    String? name,
    CharacterClassEnum? characterClass,
    int? hp,
    int? furyHit,
    int? furyDefense,
    int? attack,
    int? magicAttack,
    int? defense,
    int? magicDefense,
    int? agility,
    double? critical,
    double? dodge,
    RarityEnum? rarity,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      characterClass: characterClass ?? this.characterClass,
      hp: hp ?? this.hp,
      furyHit: furyHit ?? this.furyHit,
      furyDefense: furyDefense ?? this.furyDefense,
      attack: attack ?? this.attack,
      magicAttack: magicAttack ?? this.magicAttack,
      defense: defense ?? this.defense,
      magicDefense: magicDefense ?? this.magicDefense,
      agility: agility ?? this.agility,
      critical: critical ?? this.critical,
      dodge: dodge ?? this.dodge,
      rarity: rarity ?? this.rarity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'characterClass': characterClass,
      'hp': hp,
      'furyHit': furyHit,
      'furyDefense': furyDefense,
      'attack': attack,
      'magicAttack': magicAttack,
      'defense': defense,
      'magicDefense': magicDefense,
      'agility': agility,
      'critical': critical,
      'dodge': dodge,
      'rarity': rarity,
    };
  }

  String toJson() => json.encode(toMap());
}
