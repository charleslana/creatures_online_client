enum CharacterClassEnum {
  water,
  fire,
  earth,
  dark,
  diamond,
  electric;

  String toJson() => name;

  static CharacterClassEnum fromJson(String json) => values.byName(json);
}

extension CharacterClassEnumExtension on CharacterClassEnum {
  String get name {
    switch (this) {
      case CharacterClassEnum.water:
        return 'Água';
      case CharacterClassEnum.fire:
        return 'Fogo';
      case CharacterClassEnum.earth:
        return 'Terra';
      case CharacterClassEnum.dark:
        return 'Sombrio';
      case CharacterClassEnum.diamond:
        return 'Diamante';
      case CharacterClassEnum.electric:
        return 'Elétrico';
      default:
        return '';
    }
  }
}
