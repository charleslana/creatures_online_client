import 'package:creatures_online_client/models/user_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider(
  (ref) => UserProvider(),
);

class UserProvider extends ValueNotifier<UserModel> {
  UserProvider() : super(UserModel(email: "", password: "", name: "Jogador"));

  void updateUser(UserModel user) {
    value = user;
  }
}