import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final landingProvider = ChangeNotifierProvider(
  (ref) => LandingProvider(),
);

class LandingProvider extends ValueNotifier<String> {
  LandingProvider() : super("");

  void changeText(String text) {
    value = text;
  }
}
