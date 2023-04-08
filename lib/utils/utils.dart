import 'package:creatures_online_client/flame/loading_game.dart';
import 'package:creatures_online_client/providers/landing_provider.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
