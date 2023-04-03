import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.keyboard_arrow_left),
              onPressed: () => controller.previousPage(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              child: const Icon(Icons.keyboard_arrow_right),
              onPressed: () => controller.nextPage(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
              ),
            )
          ],
        ),
      ),
    );
  }
}
