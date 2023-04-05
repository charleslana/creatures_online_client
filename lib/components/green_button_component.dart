import 'package:creatures_online_client/utils/data_image.dart';
import 'package:flutter/material.dart';

class GreenButtonComponent extends StatelessWidget {
  const GreenButtonComponent({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 210,
        height: 90,
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
              'Jogar!'.toUpperCase(),
              style: const TextStyle(
                inherit: true,
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: [
                  Shadow(
                    // bottomLeft
                    offset: Offset(-2, -2), color: Colors.black,
                  ),
                  Shadow(
                    // bottomRight
                    offset: Offset(2, -2), color: Colors.black,
                  ),
                  Shadow(
                    // topRight
                    offset: Offset(2, 2), color: Colors.black,
                  ),
                  Shadow(
                    // topLeft
                    offset: Offset(-2, 2), color: Colors.black,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      // child: Container(
      //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      //   decoration: BoxDecoration(
      //     gradient: const LinearGradient(
      //       colors: [
      //         Color(0xff89e35f),
      //         Color(0xff53ce39),
      //       ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     ),
      //     borderRadius: BorderRadius.circular(15),
      //     border: Border.all(
      //       width: 4,
      //       color: Colors.black,
      //     ),
      //     boxShadow: const [
      //       BoxShadow(
      //         color: Colors.black,
      //         blurRadius: 1,
      //         spreadRadius: 0,
      //       ),
      //       BoxShadow(
      //         color: Colors.white,
      //         blurRadius: 10,
      //         spreadRadius: 5,
      //       ),
      //     ],
      //   ),
      //   child: Text(
      //     text.toUpperCase(),
      //     style: const TextStyle(
      //       inherit: true,
      //       fontSize: 25,
      //       fontWeight: FontWeight.w500,
      //       color: Colors.white,
      //       shadows: [
      //         Shadow(
      //           // bottomLeft
      //           offset: Offset(-2, -2), color: Colors.black,
      //         ),
      //         Shadow(
      //           // bottomRight
      //           offset: Offset(2, -2), color: Colors.black,
      //         ),
      //         Shadow(
      //           // topRight
      //           offset: Offset(2, 2), color: Colors.black,
      //         ),
      //         Shadow(
      //           // topLeft
      //           offset: Offset(-2, 2), color: Colors.black,
      //         ),
      //       ],
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
    );
  }
}
