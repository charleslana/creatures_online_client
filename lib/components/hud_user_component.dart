import 'dart:math';

import 'package:creatures_online_client/providers/user_provider.dart';
import 'package:creatures_online_client/services/user_service.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../data/image_data.dart';
import '../flame/bar_game.dart';
import '../routes/app_routes.dart';
import '../utils/utils.dart';

class HudUserComponent extends ConsumerWidget {
  const HudUserComponent({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    final userService = UserService();
    userService.logout().then((_) => {
          pushReplacementNamed(context, landingRoute),
        });
  }

  int _getRandomNumber() {
    final Random random = Random();
    final int randomNumber = random.nextInt(9000) + 1000;
    return randomNumber;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => _logout(context),
          child: Container(
            width: 110,
            height: 110,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kolinAvatar),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                ref.watch(userProvider).value.name ??
                    'Jogador${_getRandomNumber()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  shadows: shadows,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 61,
                  height: 61,
                  child: SimpleShadow(
                    opacity: 0.6,
                    offset: const Offset(5, 5),
                    sigma: 7,
                    child: Container(
                      width: 61,
                      height: 61,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(recruit1),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: 30,
                          height: 50,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                shadows: shadows,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '5/10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: shadows,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      height: 9,
                      child: GameWidget<BarGame>(game: BarGame()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
