import 'dart:async';

import 'package:creatures_online_client/flame/components/loading_animated_component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class LoadingGame extends FlameGame {
  @override
  Color backgroundColor() => Colors.transparent;

  @override
  FutureOr<void> onLoad() async {
    await add(LoadingAnimatedComponent());
    return super.onLoad();
  }
}
