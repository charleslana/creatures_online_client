import 'package:creatures_online_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final landingProvider = ChangeNotifierProvider(
  (ref) => LandingProvider(""),
);

class LandingProvider extends ValueNotifier<dynamic> {
  LandingProvider(this.text) : super("");

  String text;

  void changeText(BuildContext context, String text) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.pop(context);
    }
    this.text = text;
    loading(context);
  }

  bool _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}

