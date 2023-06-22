import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamViewProvider = ChangeNotifierProvider(
  (ref) => TeamViewProvider(),
);

class TeamViewProvider extends ValueNotifier<int> {
  TeamViewProvider() : super(0);

  final controller = PageController();

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    value = value + 1;
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    value = value - 1;
  }
}
