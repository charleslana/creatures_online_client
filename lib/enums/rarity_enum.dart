enum RarityEnum {
  sss,
  ss,
  s,
  a,
  b,
  c,
  d;

  String toJson() => name;

  static RarityEnum fromJson(String json) => values.byName(json);
}
