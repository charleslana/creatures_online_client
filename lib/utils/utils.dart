import 'package:creatures_online_client/data/audio_data.dart';
import 'package:creatures_online_client/flame/loading_game.dart';
import 'package:creatures_online_client/providers/landing_provider.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/toast_enum.dart';
import '../providers/sound_provider.dart';

void loading(BuildContext context) {
  showDialog<dynamic>(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return Consumer(builder: (_, ref, __) {
        final text = ref.watch(landingProvider).value;
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 115,
                        height: 115,
                        child: GameWidget<LoadingGame>(game: LoadingGame()),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    text.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

void pushNamed(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

void pushReplacementNamed(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

final List<Shadow> shadows = [
  const Shadow(
    // bottomLeft
    offset: Offset(-2, -2), color: Colors.black,
  ),
  const Shadow(
    // bottomRight
    offset: Offset(2, -2), color: Colors.black,
  ),
  const Shadow(
    // topRight
    offset: Offset(2, 2), color: Colors.black,
  ),
  const Shadow(
    // topLeft
    offset: Offset(-2, 2), color: Colors.black,
  ),
];

Future<void> clickButton(WidgetRef ref) async {
  final sound = await ref.watch(soundProvider).getSound();
  if (sound) {
    FlameAudio.play(buttonClickAudio);
  }
}

void showToast(BuildContext context, String message, ToastEnum toast) {
  final snackBar = SnackBar(
    content: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: toast == ToastEnum.error ? Colors.red : Colors.green[900],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    dismissDirection: DismissDirection.none,
    duration: const Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 100,
      right: 20,
      left: 20,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String getAPI() {
  return dotenv.env['API'].toString();
}