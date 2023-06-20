import 'package:creatures_online_client/models/user_character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userCharacterProvider = ChangeNotifierProvider(
  (ref) => UserCharacterProvider(),
);

class UserCharacterProvider extends ValueNotifier<List<UserCharacterModel>> {
  UserCharacterProvider()
      : super(
          [],
        );
}
