import 'package:creatures_online_client/data/map_data.dart';
import 'package:creatures_online_client/providers/map_view_prodiver.dart';
import 'package:creatures_online_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/image_data.dart';

class MapViewComponent extends ConsumerWidget {
  const MapViewComponent({Key? key}) : super(key: key);

  Future<void> _tapNextPage(WidgetRef ref) async {
    await clickButton(ref);
    ref.read(mapViewProvider.notifier).nextPage();
  }

  Future<void> _tapPreviousPage(WidgetRef ref) async {
    await clickButton(ref);
    ref.read(mapViewProvider.notifier).previousPage();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(mapViewProvider).value;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.read(mapViewProvider.notifier).controller,
          onPageChanged: (int index) {
            print('Page ${index + 1}');
          },
          children: getMap1(size),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (page > 0)
                InkWell(
                  onTap: () => _tapPreviousPage(ref),
                  child: SizedBox(
                    height: 135,
                    child: Transform.scale(
                      scaleX: -1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(btnArrowRight),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              if (page < 1) ...[
                InkWell(
                  onTap: () => _tapNextPage(ref),
                  child: SizedBox(
                    height: 135,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(btnArrowRight),
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
