import 'package:creatures_online_client/data/image_data.dart';
import 'package:flutter/material.dart';

class ProgressBarComponent extends StatefulWidget {
  const ProgressBarComponent({Key? key}) : super(key: key);

  @override
  State<ProgressBarComponent> createState() => _ProgressBarComponentState();
}

class _ProgressBarComponentState extends State<ProgressBarComponent> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Stack(
      children: [
        IntrinsicHeight(
          child: Container(
            width: 50,
            height: 20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                AssetImage(hpBarSmallBg),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Container(
            width: 50 * 0.5,
            height: 20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                AssetImage(hpBarSmallFill),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
