import 'dart:async';

import 'package:creatures_online_client/flame/components/btn_sound_component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnSoundGame extends FlameGame {
  BtnSoundGame(this.ref);

  final WidgetRef ref;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  FutureOr<void> onLoad() async {
    await add(BtnSoundComponent());
    return super.onLoad();
  }
}
