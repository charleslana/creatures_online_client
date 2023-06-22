import 'package:creatures_online_client/components/btn_sound_component.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/green_back_button_component.dart';
import '../components/green_button_component.dart';
import '../components/progress_bar_component.dart';
import '../data/image_data.dart';
import '../enums/toast_enum.dart';
import '../models/user_character_model.dart';
import '../models/user_character_slot_model.dart';
import '../providers/team_view_prodiver.dart';
import '../providers/user_character_provider.dart';
import '../services/user_character_service.dart';

List<UserCharacterModel> _userCharacterData = [];
late List<UserCharacterModel> _unequippedTeam;
late int _teamCounts;
late UserCharacterModel? _team1;
late UserCharacterModel? _team2;
late UserCharacterModel? _team3;
late UserCharacterModel? _target;
bool _moveTeam1 = true;
bool _moveTeam2 = true;
bool _moveTeam3 = true;
bool _drag = false;
bool _drop = false;
bool _change = false;
final _userCharacterService = UserCharacterService();

Future<void> showTeam(BuildContext context, WidgetRef ref) async {
  await _mountTeam(ref);
  await clickButton(ref);
  if (!context.mounted) {
    return;
  }
  await showGeneralDialog(
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
            if (_change) {
              _confirm(setState, context, ref);
              return false;
            }
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: ref.read(teamViewProvider.notifier).controller,
                onPageChanged: (int index) {
                  print('Page ${index + 1}');
                },
                children: [
                  Container(
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
                            if (_change) ...[
                              GreenButtonComponent(
                                text: 'Salvar',
                                callback: () => {
                                  clickButton(ref),
                                  _saveTeam(setState, context, ref),
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
                            const BtnSoundComponent(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    _teamSlot1(setState, ref),
                                    _teamSlot2(setState, ref),
                                    _teamSlot3(setState, ref),
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
                                            _unequippedTeam.length +
                                                _teamCounts, (index) {
                                          if (index < _unequippedTeam.length) {
                                            final userCharacter =
                                                _unequippedTeam[index];
                                            return Card(
                                              elevation: 0,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
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
                                                  setState,
                                                  ref),
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
                                                bottomRight:
                                                    Radius.circular(10),
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
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _tapPreviousPage(ref),
                      child: const Text('Back page'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

Future<void> _mountTeam(WidgetRef ref) async {
  _teamCounts = 6;
  await Future.delayed(const Duration(), () {
    _userCharacterData = ref.watch(userCharacterProvider).value;
  });
  _team1 = _userCharacterData.firstWhereOrNull((uc) => uc.slot == 1);
  _team2 = _userCharacterData.firstWhereOrNull((uc) => uc.slot == 2);
  _team3 = _userCharacterData.firstWhereOrNull((uc) => uc.slot == 3);
  _unequippedTeam = _userCharacterData.where((uc) => uc.slot == null).toList();
  if (_unequippedTeam.length > _teamCounts) {
    _teamCounts = 0;
    return;
  }
  _teamCounts = _teamCounts - _unequippedTeam.length;
}

void _confirm(Function setState, BuildContext context, WidgetRef ref) {
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
              _saveTeam(setState, context, ref);
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

Future<void> _saveTeam(
    Function setState, BuildContext context, WidgetRef ref) async {
  loading(context, isCircular: true);
  final List<UserCharacterModel> list = [_team1!, _team2!, _team3!];
  final teamSlot1 = UserCharacterSlotModel(
    characterId: _team1!.id,
    slot: _team1!.slot!,
  );
  final teamSlot2 = UserCharacterSlotModel(
    characterId: _team2!.id,
    slot: _team2!.slot!,
  );
  final teamSlot3 = UserCharacterSlotModel(
    characterId: _team3!.id,
    slot: _team3!.slot!,
  );
  final List<UserCharacterSlotModel> slotList = [
    teamSlot1,
    teamSlot2,
    teamSlot3
  ];
  final response = await _userCharacterService.updateSlot(slotList);
  if (response.error) {
    pop(context);
    if (response.validation != null) {
      showToast(context, response.validation!.body.message, ToastEnum.error);
      return;
    }
    showToast(context, response.message, ToastEnum.error);
    return;
  }
  pop(context);
  showToast(context, response.message, ToastEnum.success);
  setState(() {
    _change = false;
  });
  list.addAll(_unequippedTeam);
  ref.read(userCharacterProvider.notifier).value = list;
}

Future<void> _tapNextPage(WidgetRef ref) async {
  await clickButton(ref);
  ref.read(teamViewProvider.notifier).nextPage();
}

Future<void> _tapPreviousPage(WidgetRef ref) async {
  await clickButton(ref);
  ref.read(teamViewProvider.notifier).previousPage();
}

Widget _teamSlot1(Function setState, WidgetRef ref) {
  if (_team1 == null) {
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            _change = true;
            _target = _team1;
            _team1 = data;
            data.slot = 1;
            _unequippedTeam.removeWhere((element) => element.id == data.id);
            _teamCounts = _teamCounts + 1;
          }),
        },
        onWillAccept: (data) => data!.slot == null,
        builder: (context, _, __) => Visibility(
          visible: _drop,
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
          if (data == _team1) {
            return;
          }
          _change = true;
          _target = _team1!;
          _team1 = data;
          _target?.slot = data.slot;
          data.slot = 1;
          if (data.slot! > 0 && _target!.slot != null && _target!.slot! > 0) {
            return;
          }
          _target?.slot = null;
          _unequippedTeam
            ..add(_target!)
            ..removeWhere((element) => element.id == data.id);
        }),
      },
      builder: (context, _, __) => GestureDetector(
        onTap: () => _tapNextPage(ref),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: _moveTeam1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            _team1!.character.characterClass)),
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
                                  text: _team1!.level.toString(),
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
                                  _team1!.character.name.toUpperCase(),
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
                                  percentage: _team1!.minHp / _team1!.maxHp,
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
                    opacity: _moveTeam1 ? 1 : 0,
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
                        data: _team1,
                        onDragStarted: () => {
                          setState(() {
                            _target = _team1!;
                            _moveTeam1 = false;
                            _drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            _team1 = _target;
                            _moveTeam1 = true;
                            _drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(_team1!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: _drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(_team1!.character.id),
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
    ),
  );
}

Widget _teamSlot2(Function setState, WidgetRef ref) {
  if (_team2 == null) {
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            _change = true;
            _target = _team2;
            _team2 = data;
            data.slot = 2;
            _unequippedTeam.removeWhere((element) => element.id == data.id);
            _teamCounts = _teamCounts + 1;
          }),
        },
        onWillAccept: (data) => data!.slot == null,
        builder: (context, _, __) => Visibility(
          visible: _drop,
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
          if (data == _team2) {
            return;
          }
          _change = true;
          _target = _team2;
          _team2 = data;
          _target?.slot = data.slot;
          data.slot = 2;
          if (data.slot! > 0 && _target!.slot != null && _target!.slot! > 0) {
            return;
          }
          _target?.slot = null;
          _unequippedTeam
            ..add(_target!)
            ..removeWhere((element) => element.id == data.id);
        }),
      },
      builder: (context, _, __) => GestureDetector(
        onTap: () => _tapNextPage(ref),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: _moveTeam2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            _team2!.character.characterClass)),
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
                                  text: _team2!.level.toString(),
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
                                  _team2!.character.name.toUpperCase(),
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
                                  percentage: _team2!.minHp / _team2!.maxHp,
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
                    opacity: _moveTeam2 ? 1 : 0,
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
                        data: _team2,
                        onDragStarted: () => {
                          setState(() {
                            _target = _team2;
                            _moveTeam2 = false;
                            _drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            _team2 = _target;
                            _moveTeam2 = true;
                            _drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(_team2!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: _drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(_team2!.character.id),
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
    ),
  );
}

Widget _teamSlot3(Function setState, WidgetRef ref) {
  if (_team3 == null) {
    return Expanded(
      child: DragTarget<UserCharacterModel>(
        onAccept: (data) => {
          setState(() {
            _change = true;
            _target = _team3;
            _team3 = data;
            data.slot = 3;
            _unequippedTeam.removeWhere((element) => element.id == data.id);
            _teamCounts = _teamCounts + 1;
          }),
        },
        onWillAccept: (data) => data!.slot == null,
        builder: (context, _, __) => Visibility(
          visible: _drop,
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
          if (data == _team3) {
            return;
          }
          _change = true;
          _target = _team3;
          _team3 = data;
          _target?.slot = data.slot;
          data.slot = 3;
          if (data.slot! > 0 && _target!.slot != null && _target!.slot! > 0) {
            return;
          }
          _target?.slot = null;
          _unequippedTeam
            ..add(_target!)
            ..removeWhere((element) => element.id == data.id);
        }),
      },
      builder: (context, _, __) => GestureDetector(
        onTap: () => _tapNextPage(ref),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Visibility(
                visible: _moveTeam3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(getCharacterTooltip(
                            _team3!.character.characterClass)),
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
                                  text: _team3!.level.toString(),
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
                                  _team3!.character.name.toUpperCase(),
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
                                  percentage: _team3!.minHp / _team3!.maxHp,
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
                    opacity: _moveTeam3 ? 1 : 0,
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
                        data: _team3,
                        onDragStarted: () => {
                          setState(() {
                            _target = _team3;
                            _moveTeam3 = false;
                            _drag = true;
                          }),
                        },
                        onDragEnd: (details) => {
                          setState(() {
                            _team3 = _target;
                            _moveTeam3 = true;
                            _drag = false;
                          }),
                        },
                        feedback: Image.asset(
                          width: 130,
                          getCharacterFront(_team3!.character.id),
                          fit: BoxFit.scaleDown,
                        ),
                        childWhenDragging: Container(),
                        child: Opacity(
                          opacity: _drag ? 0.5 : 1,
                          child: Image.asset(
                            getCharacterFront(_team3!.character.id),
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
    ),
  );
}

Widget _buildTeamUnequipped(UserCharacterModel userCharacter,
    BuildContext context, Function setState, WidgetRef ref) {
  return Draggable<UserCharacterModel>(
    data: userCharacter,
    onDragStarted: () => {
      setState(() {
        _drag = true;
        _drop = true;
      }),
    },
    onDragEnd: (details) => {
      setState(() {
        _drag = false;
        _drop = false;
      }),
    },
    feedback: Image.asset(
      height: 100,
      getCharacterFront(userCharacter.character.id),
      fit: BoxFit.scaleDown,
    ),
    childWhenDragging: Container(),
    child: GestureDetector(
      onTap: () => _tapNextPage(ref),
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
    ),
  );
}
