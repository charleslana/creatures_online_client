import 'dart:async';

import 'package:creatures_online_client/flame/components/empty_bar_component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BarGame extends FlameGame {
  late EmptyBarComponent bar;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  FutureOr<void> onLoad() async {
    await add(EmptyBarComponent());
    return super.onLoad();
  }
}
