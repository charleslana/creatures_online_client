import 'package:creatures_online_client/components/green_back_button_component.dart';
import 'package:creatures_online_client/components/green_button_component.dart';
import 'package:creatures_online_client/components/progress_bar_component.dart';
import 'package:creatures_online_client/models/user_character_model.dart';
import 'package:creatures_online_client/providers/user_provider.dart';
import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:creatures_online_client/services/user_character_service.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/image_data.dart';
import '../enums/toast_enum.dart';
import '../flame/btn_sound_game.dart';
import '../utils/utils.dart';

class MenuBottomComponent extends ConsumerStatefulWidget {
  const MenuBottomComponent({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuBottomComponent> createState() =>
      _MenuBottomComponentState();
}

class _MenuBottomComponentState extends ConsumerState<MenuBottomComponent> {
  List<UserCharacterModel> userCharacterData = [];
  late List<UserCharacterModel> unequippedTeam;
  int teamCounts = 6;
  late UserCharacterModel? team1;
  late UserCharacterModel? team2;
  late UserCharacterModel? team3;
  late UserCharacterModel? target;
  bool moveTeam1 = true;
  bool moveTeam2 = true;
  bool moveTeam3 = true;
  bool drag = false;
  bool drop = false;
  bool change = false;
  final userCharacterService = UserCharacterService();

  @override
  void initState() {
    mountTeam();
    super.initState();
  }

  Future<void> mountTeam() async {
    await Future.delayed(const Duration(), () {
      userCharacterData = ref.watch(userProvider).value.characters;
    });
    team1 = userCharacterData.firstWhereOrNull((uc) => uc.slot == 1);
    team2 = userCharacterData.firstWhereOrNull((uc) => uc.slot == 2);
    team3 = userCharacterData.firstWhereOrNull((uc) => uc.slot == 3);
    unequippedTeam = userCharacterData.where((uc) => uc.slot == 0).toList();
    teamCounts = teamCounts - unequippedTeam.length;
  }

  @override
  Widget build(BuildContext context) {
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
          _menu('Mundo', btnWorld,
              () => pushReplacementNamed(context, worldRoute)),
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

  void _confirm(Function setState) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          title: const Text(''),
          content: const Text(
              'Uma ou mais alterações foram feitas no seu time, deseja salvar?'),
          actions: [
            TextButton(
              onPressed: () {
                pop(context);
                saveTeam(setState);
              },
              child: const Text('Salvar alterações'),
            ),
            TextButton(
              onPressed: () {
                pop(context);
              },
              child: const Text('Cancelar alterações'),
            )
          ],
        );
      },
    );
  }

  Future<void> saveTeam(Function setState) async {
    loading(context, isCircular: true);
    final List<UserCharacterModel> list = [team1!, team2!, team3!];
    final response = await userCharacterService.updateSlot(list);
    if (!mounted) {
      return;
    }
    if (response.error) {
      pop(context);
      showToast(context, response.message, ToastEnum.error);
      return;
    }
    pop(context);
    showToast(context, response.message, ToastEnum.success);
    setState(() {
      change = false;
    });
    final user = ref.watch(userProvider).value;
    list.addAll(unequippedTeam);
    ref.read(userProvider.notifier).value = user.copyWith(characters: list);
  }

  void showTeam(BuildContext context, WidgetRef ref) {
    clickButton(ref);
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation<dynamic> animation,
          Animation<dynamic> secondaryAnimation) {
        return StatefulBuilder(builder: (_, setState) {
          return WillPopScope(
            onWillPop: () async {
              await clickButton(ref);
              if (change) {
                _confirm(setState);
                return false;
              }
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
                          if (change) ...[
                            GreenButtonComponent(
                              text: 'Salvar',
                              callback: () => {
                                clickButton(ref),
                                saveTeam(setState),
                              },
                              isBig: false,
                            ),
                          ] else ...[
                            GreenBackButtonComponent(
                              text: 'Voltar',
                              callback: () => {
                                clickButton(ref),
                                pop(context),
                              },
                            ),
                          ],
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: GameWidget<BtnSoundGame>(
                                game: BtnSoundGame(ref)),
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
                                  _teamSlot1(setState),
                                  _teamSlot2(setState),
                                  _teamSlot3(setState),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox.expand(
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: const Color(0xfffcf4ac),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: GridView.count(
                                      childAspectRatio: 1 / .6,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      crossAxisCount: 2,
                                      children: List.generate(
                                          unequippedTeam.length + teamCounts,
                                          (index) {
                                        if (index < unequippedTeam.length) {
                                          final userCharacter =
                                              unequippedTeam[index];
                                          return Card(
                                            elevation: 0,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                topLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            color: const Color(0xffe7daa2),
                                            child: _buildTeamUnequipped(
                                                userCharacter,
                                                context,
                                                setState),
                                          );
                                        }
                                        return const Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Color(0xffdaca9c),
                                              width: 4,
                                            ),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          color: Color(0xffe7daa2),
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
        });
      },
    );
  }

  Widget _teamSlot1(Function setState) {
    if (team1 == null) {
      return Expanded(
        child: DragTarget<UserCharacterModel>(
          onAccept: (data) => {
            setState(() {
              change = true;
              target = team1;
              team1 = data;
              data.slot = 1;
              unequippedTeam.removeWhere((element) => element.id == data.id);
              teamCounts = teamCounts + 1;
            }),
          },
          onWillAccept: (data) => data!.slot == 0,
          builder: (context, _, __) => Visibility(
            visible: drop,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.green.withOpacity(0.3),
                      child: const Center(
                        child: Text(
                          'Slot 1',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            if (data == team1) {
              return;
            }
            change = true;
            target = team1!;
            team1 = data;
            target?.slot = data.slot;
            data.slot = 1;
            if (data.slot! > 0 && target!.slot! > 0) {
              return;
            }
            target?.slot = 0;
            unequippedTeam
              ..add(target!)
              ..removeWhere((element) => element.id == data.id);
          }),
        },
        builder: (context, _, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: moveTeam1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            team1!.character.characterClass)),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          left: 3,
                          child: RichText(
                            text: TextSpan(
                              text: 'Nv. ',
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: team1!.level.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  team1!.character.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: ProgressBarComponent(
                                  width: 100,
                                  height: 30,
                                  percentage: team1!.minHp / team1!.maxHp,
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
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Opacity(
                    opacity: moveTeam1 ? 1 : 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        monShadow,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Draggable<UserCharacterModel>(
                        data: team1,
                        onDragStarted: () => {
                          setState(() {
                            target = team1!;
                            moveTeam1 = false;
                            drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            team1 = target;
                            moveTeam1 = true;
                            drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(team1!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(team1!.character.id),
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter,
                          ),
                        ),
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
    );
  }

  Widget _teamSlot2(Function setState) {
    if (team2 == null) {
      return Expanded(
        child: DragTarget<UserCharacterModel>(
          onAccept: (data) => {
            setState(() {
              change = true;
              target = team2;
              team2 = data;
              data.slot = 2;
              unequippedTeam.removeWhere((element) => element.id == data.id);
              teamCounts = teamCounts + 1;
            }),
          },
          onWillAccept: (data) => data!.slot == 0,
          builder: (context, _, __) => Visibility(
            visible: drop,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.green.withOpacity(0.3),
                      child: const Center(
                        child: Text(
                          'Slot 2',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            if (data == team2) {
              return;
            }
            change = true;
            target = team2;
            team2 = data;
            target?.slot = data.slot;
            data.slot = 2;
            if (data.slot! > 0 && target!.slot! > 0) {
              return;
            }
            target?.slot = 0;
            unequippedTeam
              ..add(target!)
              ..removeWhere((element) => element.id == data.id);
          }),
        },
        builder: (context, _, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: moveTeam2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            team2!.character.characterClass)),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          left: 3,
                          child: RichText(
                            text: TextSpan(
                              text: 'Nv. ',
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: team2!.level.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  team2!.character.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: ProgressBarComponent(
                                  width: 100,
                                  height: 30,
                                  percentage: team2!.minHp / team2!.maxHp,
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
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Opacity(
                    opacity: moveTeam2 ? 1 : 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        monShadow,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Draggable<UserCharacterModel>(
                        data: team2,
                        onDragStarted: () => {
                          setState(() {
                            target = team2;
                            moveTeam2 = false;
                            drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            team2 = target;
                            moveTeam2 = true;
                            drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(team2!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(team2!.character.id),
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter,
                          ),
                        ),
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
    );
  }

  Widget _teamSlot3(Function setState) {
    if (team3 == null) {
      return Expanded(
        child: DragTarget<UserCharacterModel>(
          onAccept: (data) => {
            setState(() {
              change = true;
              target = team3;
              team3 = data;
              data.slot = 3;
              unequippedTeam.removeWhere((element) => element.id == data.id);
              teamCounts = teamCounts + 1;
            }),
          },
          onWillAccept: (data) => data!.slot == 0,
          builder: (context, _, __) => Visibility(
            visible: drop,
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  child: SizedBox.expand(
                    child: Container(
                      color: Colors.green.withOpacity(0.3),
                      child: const Center(
                        child: Text(
                          'Slot 3',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            if (data == team3) {
              return;
            }
            change = true;
            target = team3;
            team3 = data;
            target?.slot = data.slot;
            data.slot = 3;
            if (data.slot! > 0 && target!.slot! > 0) {
              return;
            }
            target?.slot = 0;
            unequippedTeam
              ..add(target!)
              ..removeWhere((element) => element.id == data.id);
          }),
        },
        builder: (context, _, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: moveTeam3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            team3!.character.characterClass)),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          left: 3,
                          child: RichText(
                            text: TextSpan(
                              text: 'Nv. ',
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: team3!.level.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  team3!.character.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    shadows: shadows,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: ProgressBarComponent(
                                  width: 100,
                                  height: 30,
                                  percentage: team3!.minHp / team3!.maxHp,
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
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Opacity(
                    opacity: moveTeam3 ? 1 : 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        monShadow,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Draggable<UserCharacterModel>(
                        data: team3,
                        onDragStarted: () => {
                          setState(() {
                            target = team3;
                            moveTeam3 = false;
                            drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            team3 = target;
                            moveTeam3 = true;
                            drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(team3!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(team3!.character.id),
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topCenter,
                          ),
                        ),
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
    );
  }

  Widget _buildTeamUnequipped(UserCharacterModel userCharacter,
      BuildContext context, Function setState) {
    return Draggable<UserCharacterModel>(
      data: userCharacter,
      onDragStarted: () => {
        setState(() {
          drag = true;
          drop = true;
        }),
      },
      onDragEnd: (details) => {
        setState(() {
          drag = false;
          drop = false;
        }),
      },
      feedback: Image.asset(
        height: 100,
        getCharacterFront(userCharacter.character.id),
        fit: BoxFit.scaleDown,
      ),
      childWhenDragging: Container(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                getCharacterThumb(userCharacter.character.characterClass)),
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
                    child: Image.asset(
                        getCharacterIcon(userCharacter.character.id)),
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
                                children: [
                                  TextSpan(
                                    text: userCharacter.level.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ProgressBarComponent(
                          width: 50,
                          height: 20,
                          percentage: userCharacter.minHp / userCharacter.maxHp,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.topCenter,
                  child: Text(
                    userCharacter.character.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      shadows: shadows,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
