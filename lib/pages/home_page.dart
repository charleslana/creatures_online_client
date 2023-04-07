import 'package:creatures_online_client/components/menu_bottom_component.dart';
import 'package:creatures_online_client/flame/bar_game.dart';
import 'package:creatures_online_client/utils/const.dart';
import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(initialPage: 0);
  int page = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void nextPage() {
    controller.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    setState(() {
      page = controller.initialPage + 1;
    });
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
    setState(() {
      page = controller.initialPage - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (int index) {
                print('Page ${index + 1}');
              },
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(areaBootcamp1),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: Text('Page 1'),
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
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (page > 0)
                    InkWell(
                      onTap: previousPage,
                      child: Transform.scale(
                        scaleX: -1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            btnArrowRight,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  if (page < 1) ...[
                    InkWell(
                      onTap: nextPage,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          btnArrowRight,
                          width: 50,
                        ),
                      ),
                    ),
                  ] else ...[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        lock,
                        width: 60,
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(kolinAvatar),
                          fit: BoxFit.contain,
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
                            'Charles',
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
                                color: Colors.black,
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
                ),
              ),
            ),
            const MenuBottomComponent(),
          ],
        ),
      ),
    );
  }
}
