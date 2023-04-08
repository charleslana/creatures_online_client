import 'package:creatures_online_client/utils/data_audio.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/shared_local_storage_service.dart';

final soundProvider = ChangeNotifierProvider(
  (ref) => SoundProvider(),
);

class SoundProvider extends ValueNotifier<bool> {
  SoundProvider() : super(true);

  final sharedLocalStorageService = SharedLocalStorageService();

  Future<void> changeSound(bool sound) async {
    value = sound;
    sharedLocalStorageService.put(sharedLocalStorageService.soundKey, sound);
    if (sound) {
      await FlameAudio.bgm.play(bgMapAudio, volume: .50);
      return;
    }
    await FlameAudio.bgm.stop();
  }

  Future<bool> getSound() async {
    final getSound = await sharedLocalStorageService
        .get<bool>(sharedLocalStorageService.soundKey);
    if (getSound != null) {
      value = getSound;
    }
    return getSound ?? true;
  }
}
