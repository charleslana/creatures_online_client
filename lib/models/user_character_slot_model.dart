import 'dart:convert';

class UserCharacterSlotModel {
  UserCharacterSlotModel({
    required this.characterId,
    required this.slot,
  });

  factory UserCharacterSlotModel.fromMap(Map<String, dynamic> map) {
    return UserCharacterSlotModel(
      characterId: map['characterId'] as String,
      slot: map['slot'] as int,
    );
  }

  factory UserCharacterSlotModel.fromJson(String source) =>
      UserCharacterSlotModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  String characterId;
  int slot;

  UserCharacterSlotModel copyWith({
    String? characterId,
    int? slot,
  }) {
    return UserCharacterSlotModel(
      characterId: characterId ?? this.characterId,
      slot: slot ?? this.slot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'characterId': characterId,
      'slot': slot,
    };
  }

  String toJson() => json.encode(toMap());

  static String modelToJson(List<UserCharacterSlotModel> data) =>
      List<dynamic>.from(data.map((x) => x.toJson())).toString();
}
