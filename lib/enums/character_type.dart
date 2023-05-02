enum CharacterType {
  dark,
  diamond,
  earth,
  electric,
  fire,
  water;

  String toJson() => name;

  static CharacterType fromJson(String json) => values.byName(json);
}
