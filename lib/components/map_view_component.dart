import 'package:creatures_online_client/providers/map_view_prodiver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/data_image.dart';

class MapViewComponent extends ConsumerWidget {
  const MapViewComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(mapViewProvider).value;

    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.read(mapViewProvider.notifier).controller,
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
                GestureDetector(
                  onTap: ref.read(mapViewProvider.notifier).previousPage,
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
                GestureDetector(
                  onTap: ref.read(mapViewProvider.notifier).nextPage,
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
      ],
    );
  }
}
