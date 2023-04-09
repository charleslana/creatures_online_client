import 'package:flutter/material.dart';

import 'image_data.dart';

List<Widget> getMap1(Size size) {
  return [
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(areaBootcamp1),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: size.height / 2.1,
            right: size.width * 0.13,
            child: InkWell(
              onTap: () => print('tap'),
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(node),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 20),
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(iconFlag),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height / 1.72,
            right: size.width * 0.25,
            child: Image.asset(pathDot),
          ),
          Positioned(
            top: size.height / 1.65,
            right: size.width * 0.3,
            child: Image.asset(pathDot),
          ),
          Positioned(
            top: size.height / 1.8,
            right: size.width * 0.32,
            child: InkWell(
              onTap: () => print('tap 2'),
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(node),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 20),
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(markerQuest),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height / 1.64,
            right: size.width * 0.46,
            child: Image.asset(pathDot),
          ),
          Positioned(
            top: size.height / 1.7,
            right: size.width * 0.52,
            child: Image.asset(pathDot),
          ),
          Positioned(
            top: size.height / 2.05,
            right: size.width * 0.55,
            child: InkWell(
              onTap: () => print('tap 3'),
              child: Column(
                verticalDirection: VerticalDirection.up,
                children: [
                  Container(
                    width: 70,
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(node),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 20),
                    child: Container(
                      width: 60,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(markerBattle),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(areaBootcamp2),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text('Page 2'),
      ),
    ),
  ];
}
