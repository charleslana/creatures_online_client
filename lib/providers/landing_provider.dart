import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final landingProvider = ChangeNotifierProvider(
  (ref) => LandingProvider(),
);

class LandingProvider extends ValueNotifier<dynamic> {
  LandingProvider() : super("");

  void changeText(BuildContext context, String text) {
    value = text;
  }
}
