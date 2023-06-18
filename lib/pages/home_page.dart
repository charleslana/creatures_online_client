import 'package:creatures_online_client/components/hud_info_component.dart';
import 'package:creatures_online_client/components/hud_user_component.dart';
import 'package:creatures_online_client/components/map_view_component.dart';
import 'package:creatures_online_client/components/menu_bottom_component.dart';
import 'package:creatures_online_client/data/audio_data.dart';
import 'package:creatures_online_client/data/image_data.dart';
import 'package:creatures_online_client/providers/dialog_provider.dart';
import 'package:creatures_online_client/providers/loading_provider.dart';
import 'package:creatures_online_client/providers/sound_provider.dart';
import 'package:creatures_online_client/services/user_service.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final nameController = TextEditingController();
  final userService = UserService();
  String errorMessage = '';

  @override
  void initState() {
    dialog();
    super.initState();
  }

  @override
  void dispose() {
    FlameAudio.bgm.stop();
    super.dispose();
  }

  Future<void> playAudio() async {
    final sound = await ref.watch(soundProvider).getSound();
    if (sound) {
      await FlameAudio.bgm.play(bgMapAudio, volume: 0.5);
    }
  }

  Future<void> dialog() async {
    await Future.delayed(const Duration(milliseconds: 1), () {
      playAudio();
      final user = ref.watch(userProvider).value;
      if (user.name != null) {
        return;
      }
      ref.read(dialogProvider.notifier).value =
          'Olá vejo que você é novo, como devo te chamar?';
      ref.read(dialogProvider.notifier).callback = () => {
            pop(context),
            showUpdateUser(),
          };
      ref.read(dialogProvider.notifier).image = dialogJovani;
      openDialog(context);
    });
  }

  void showUpdateUser() {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        autofocus: true,
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Como você se chama',
                        ),
                      ),
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.start,
                        ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await updateUser(setState);
                          },
                          child: const Text('Continuar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> updateUser(StateSetter setState) async {
    closeKeyboard();
    setState(() {
      errorMessage = '';
    });
    if (nameController.text == '') {
      setState(() {
        errorMessage = 'Nome em branco';
      });
      return;
    }
    ref.read(loadingProvider.notifier).value = '';
    loading(context);
    final response = await userService.updateUserName(nameController.text);
    if (!mounted) {
      return;
    }
    if (response.error) {
      pop(context);
      if (response.validation != null) {
        setState(() {
          errorMessage = response.validation!.body.message;
        });
        return;
      }
      setState(() {
        errorMessage = response.message;
      });
    } else {
      pop(context);
      pop(context);
      final user = ref.watch(userProvider).value;
      ref.read(userProvider.notifier).value =
          user.copyWith(name: nameController.text);
      finishUpdateUser();
    }
  }

  void finishUpdateUser() {
    final name = ref.watch(userProvider).value.name.toString();
    ref.read(dialogProvider.notifier).value =
        'Certo $name, a sua aventura começa agora!';
    ref.read(dialogProvider.notifier).callback = () => pop(context);
    ref.read(dialogProvider.notifier).image = dialogJovaniHand;
    openDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MapViewComponent(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HudUserComponent(),
                    SizedBox(height: 20),
                    HudInfoComponent(),
                  ],
                ),
              ),
            ),
            MenuBottomComponent(),
          ],
        ),
      ),
    );
  }
}
