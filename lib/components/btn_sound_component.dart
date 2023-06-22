import 'package:creatures_online_client/data/image_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sound_provider.dart';
import '../utils/utils.dart';

class BtnSoundComponent extends ConsumerWidget {
  const BtnSoundComponent({super.key});

  Future<void> _toggleAudio(WidgetRef ref) async {
    final getSound = ref.watch(soundProvider).value;
    if (getSound) {
      await ref.read(soundProvider.notifier).changeSound();
      return;
    }
    await ref.read(soundProvider.notifier).changeSound(hasSound: true);
    await clickButton(ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSound = ref.watch(soundProvider).value;

    return GestureDetector(
      onTap: () => _toggleAudio(ref),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Image.asset(getSound ? btnSound : btnSoundOff),
      ),
    );
  }
}
