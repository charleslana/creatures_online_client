import 'package:creatures_online_client/data/image_data.dart';
import 'package:flutter/material.dart';

class ProgressBarComponent extends StatefulWidget {
  const ProgressBarComponent({
    Key? key,
    required this.width,
    required this.height,
    required this.percentage,
    this.isLarge = false,
  }) : super(key: key);

  final double width;
  final double height;
  final double percentage;
  final bool isLarge;

  @override
  State<ProgressBarComponent> createState() => _ProgressBarComponentState();
}

class _ProgressBarComponentState extends State<ProgressBarComponent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntrinsicHeight(
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.isLarge ? hpBarMedBg : hpBarSmallBg),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Container(
            width: widget.width * widget.percentage,
            height: widget.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(widget.isLarge ? hpBarMedFill : hpBarSmallFill),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
