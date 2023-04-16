import 'package:creatures_online_client/components/green_back_button_component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/image_data.dart';
import '../flame/btn_sound_game.dart';
import '../utils/utils.dart';

class MenuBottomComponent extends ConsumerWidget {
  const MenuBottomComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: 0,
      bottom: 10,
      width: MediaQuery.of(context).size.width,
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        children: [
          _menu('Loja', btnShop, () => {}),
          _menu('Mundo', btnWorld, () => {}),
          _menu('Missão', btnMission, () => {}),
          _menu('Itens', btnItems, () => {}),
          _menu('Equipe', btnTeam, () => showTeam(context, ref)),
        ],
      ),
    );
  }

  Widget _menu(String text, String image, VoidCallback callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.contain,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                shadows: shadows,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showTeam(BuildContext context, WidgetRef ref) {
    clickButton(ref);
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async {
            clickButton(ref);
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgTeam),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GreenBackButtonComponent(
                          text: 'Voltar',
                          callback: () => {
                            clickButton(ref),
                            pop(context),
                          },
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: GameWidget<BtnSoundGame>(game: BtnSoundGame(ref)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
