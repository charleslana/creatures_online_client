import 'dart:math';

import 'package:flutter/material.dart';

class GradientProgressComponent extends StatefulWidget {
  const GradientProgressComponent({Key? key}) : super(key: key);

  @override
  State<GradientProgressComponent> createState() =>
      _GradientProgressComponentState();
}

class _GradientProgressComponentState extends State<GradientProgressComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller
      ..addListener(() => setState(() {}))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.toDouble(), end: 1.toDouble()).animate(_controller),
      child: CustomPaint(
        size: const Size.fromRadius(30),
        painter: GradientCircularProgressPainter(
          radius: 30,
          gradientColors: [
            Colors.blue,
            Colors.lightBlueAccent,
          ],
          strokeWidth: 15,
        ),
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.radius,
    required this.gradientColors,
    required this.strokeWidth,
  });

  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    final double offset = strokeWidth / 2;
    final Rect rect = Offset(offset, offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(colors: gradientColors).createShader(rect);
    canvas.drawArc(rect, 0, 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
