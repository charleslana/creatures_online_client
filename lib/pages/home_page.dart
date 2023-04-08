import 'package:creatures_online_client/components/hud_info_component.dart';
import 'package:creatures_online_client/components/hud_user_component.dart';
import 'package:creatures_online_client/components/map_view_component.dart';
import 'package:creatures_online_client/components/menu_bottom_component.dart';
import 'package:creatures_online_client/providers/sound_provider.dart';
import 'package:creatures_online_client/utils/data_audio.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void didChangeDependencies() {
    playAudio();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    FlameAudio.bgm.stop();
    super.dispose();
  }

  Future<void> playAudio() async {
    final sound = await ref.watch(soundProvider).getSound();
    if (sound) {
      FlameAudio.bgm.play(bgMapAudio, volume: 0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const MapViewComponent(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    HudUserComponent(),
                    SizedBox(height: 20),
                    HudInfoComponent(),
                  ],
                ),
              ),
            ),
            const MenuBottomComponent(),
          ],
        ),
      ),
    );
  }
}
