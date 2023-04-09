import 'package:creatures_online_client/data/map_data.dart';
import 'package:creatures_online_client/providers/map_view_prodiver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/image_data.dart';

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
          children: getMap1(),
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
