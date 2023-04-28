import 'package:creatures_online_client/components/green_back_button_component.dart';
import 'package:creatures_online_client/components/progress_bar_component.dart';
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
                          child:
                              GameWidget<BtnSoundGame>(game: BtnSoundGame(ref)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    paneTooltipEarth),
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned.fill(
                                                  top: 0,
                                                  left: 3,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Nv. ',
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: const [
                                                        TextSpan(
                                                          text: '55',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 20,
                                                    left: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Kikflick'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          inherit: true,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          shadows: shadows,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      const Expanded(
                                                        child:
                                                            ProgressBarComponent(
                                                          width: 100,
                                                          height: 30,
                                                          percentage: 1,
                                                          isLarge: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                monShadow,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned.fill(
                                              bottom: 10,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Image.asset(
                                                  monFrontKikflick,
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(paneTooltipFire),
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned.fill(
                                                  top: 0,
                                                  left: 3,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Nv. ',
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: const [
                                                        TextSpan(
                                                          text: '55',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 20,
                                                    left: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Menza'.toUpperCase(),
                                                        style: TextStyle(
                                                          inherit: true,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          shadows: shadows,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      const Expanded(
                                                        child:
                                                            ProgressBarComponent(
                                                          width: 100,
                                                          height: 30,
                                                          percentage: 1,
                                                          isLarge: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                monShadow,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned.fill(
                                              bottom: 10,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Image.asset(
                                                  monFrontMenza,
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    paneTooltipWater),
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.topCenter,
                                              ),
                                            ),
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Positioned.fill(
                                                  top: 0,
                                                  left: 3,
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Nv. ',
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: const [
                                                        TextSpan(
                                                          text: '55',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 20,
                                                    left: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Snorky'.toUpperCase(),
                                                        style: TextStyle(
                                                          inherit: true,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                          shadows: shadows,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      const Expanded(
                                                        child:
                                                            ProgressBarComponent(
                                                          width: 100,
                                                          height: 30,
                                                          percentage: 1,
                                                          isLarge: true,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Image.asset(
                                                monShadow,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned.fill(
                                              bottom: 10,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Image.asset(
                                                  monFrontSnorky,
                                                  fit: BoxFit.scaleDown,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox.expand(
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: const Color(0xfffcf4ac),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: GridView.count(
                                    childAspectRatio: (1 / .6),
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    crossAxisCount: 2,
                                    children: List.generate(10, (index) {
                                      return Card(
                                        elevation: 0,
                                        shape: const RoundedRectangleBorder(
                                          // side: BorderSide(
                                          //   color: Color(0xffdaca9c),
                                          //   width: 4,
                                          // ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        color: const Color(0xffe7daa2),
                                        child: _buildTeamUnequipped(index == 0,
                                            context, hudPaneThumbDark),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTeamUnequipped(bool hasValue, BuildContext context,
      [String? image]) {
    if (hasValue) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image!),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(monIconAmuranther),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Nv. ',
                                style: DefaultTextStyle.of(context).style,
                                children: const [
                                  TextSpan(
                                    text: '55',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: ProgressBarComponent(
                          width: 50,
                          height: 20,
                          percentage: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(width: 10),
                ),
              ],
            ),
            Positioned.fill(
              top: -5,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: Text(
                  'Amuranther'.toUpperCase(),
                  style: TextStyle(
                    inherit: true,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    shadows: shadows,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
