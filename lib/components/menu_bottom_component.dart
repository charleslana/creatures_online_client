import 'package:creatures_online_client/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/image_data.dart';
import '../menus/team_menu.dart';
import '../utils/utils.dart';

class MenuBottomComponent extends ConsumerWidget {
  const MenuBottomComponent({super.key});

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
          _menu('Mundo', btnWorld,
              () => pushReplacementNamed(context, worldRoute)),
          _menu('Missão', btnMission, () => {}),
          _menu('Itens', btnItems, () => {}),
          _menu('Equipe', btnTeam, () => showTeam(context, ref)),
        ],
      ),
    );
  }
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
