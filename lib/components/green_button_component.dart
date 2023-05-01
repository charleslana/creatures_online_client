import 'package:creatures_online_client/data/image_data.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GreenButtonComponent extends StatelessWidget {
  const GreenButtonComponent({
    Key? key,
    required this.text,
    required this.callback,
    this.isBig = true,
  }) : super(key: key);

  final String text;
  final VoidCallback callback;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: isBig ? 210 : 124,
        height: isBig ? 90 : 53,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          image: const DecorationImage(
            image: AssetImage(btnGreen),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                inherit: true,
                fontSize: isBig ? 35 : 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: shadows,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
