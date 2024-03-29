import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mapViewProvider = ChangeNotifierProvider(
  (ref) => MapViewProvider(),
);

class MapViewProvider extends ValueNotifier<int> {
  MapViewProvider() : super(0);

  final controller = PageController();

  void nextPage() {
    controller.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    value = value + 1;
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    value = value - 1;
  }
}
