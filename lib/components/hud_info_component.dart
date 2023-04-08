import 'package:flutter/material.dart';

import '../utils/const.dart';
import '../utils/data_image.dart';

class HudInfoComponent extends StatelessWidget {
  const HudInfoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 2,
            ),
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(hudMapInfo),
                fit: BoxFit.contain,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '0%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  shadows: shadows,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(
              left: 30,
              bottom: 2,
            ),
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(hudShard),
                fit: BoxFit.contain,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  shadows: shadows,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(
              left: 25,
              bottom: 2,
            ),
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(hudGold),
                fit: BoxFit.contain,
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '100.9M',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  shadows: shadows,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: Image.asset(btnSoundOff),
          ),
        ),
      ],
    );
  }
}
