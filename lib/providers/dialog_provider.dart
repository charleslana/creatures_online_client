import 'package:creatures_online_client/data/image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dialogProvider = ChangeNotifierProvider(
  (ref) => DialogProvider(),
);

class DialogProvider extends ValueNotifier<String> {
  DialogProvider() : super("");

  late VoidCallback callback;

  String image = dialogJovani;

  void changeText(String text) {
    value = text;
  }
}
