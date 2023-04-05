import 'package:flutter/material.dart';

import '../utils/data_image.dart';

class MenuBottomComponent extends StatelessWidget {
  const MenuBottomComponent({Key? key}) : super(key: key);

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
          InkWell(
            onTap: () => {},
            child: Image.asset(btnShop),
          ),
          InkWell(
            onTap: () => {},
            child: Image.asset(btnWorld),
          ),
          InkWell(
            onTap: () => {},
            child: Image.asset(btnMission),
          ),
          InkWell(
            onTap: () => {},
            child: Image.asset(btnItems),
          ),
          InkWell(
            onTap: () => {},
            child: Image.asset(btnTeam),
          ),
        ],
      ),
    );
  }
}
