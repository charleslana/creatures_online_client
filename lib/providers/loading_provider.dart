import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = ChangeNotifierProvider(
  (ref) => LoadingProvider(),
);

class LoadingProvider extends ValueNotifier<String> {
  LoadingProvider() : super("");

  void changeText(String text) {
    value = text;
  }
}
