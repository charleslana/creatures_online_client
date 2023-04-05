import 'package:creatures_online_client/components/menu_bottom_component.dart';
import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flutter/material.dart';

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
            const MenuBottomComponent(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (page > 0)
                      FloatingActionButton.large(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        heroTag: 'left',
                        onPressed: previousPage,
                        child: Transform.scale(
                          scaleX: -1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(btnArrowRight),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (page < 1) ...[
                      FloatingActionButton.large(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        heroTag: 'right',
                        onPressed: nextPage,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(btnArrowRight),
                        ),
                      ),
                    ] else ...[
                      const FloatingActionButton(
                        heroTag: 'right',
                        onPressed: null,
                        child: Icon(Icons.lock),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
