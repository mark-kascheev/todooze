import 'dart:math';

import 'package:flutter/material.dart';

class CircularProjectProgress extends StatelessWidget {
  final double radius;
  final String projectId;

  const CircularProjectProgress(
      {Key? key, required this.radius, required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _CircleProgress(), size: Size(radius, radius));
  }
}

class _CircleProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 3
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;

    Paint innerCircle = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width, size.height), size.width, outerCircle);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width, size.height), radius: size.width - 4),
        -pi / 2,
        pi * 1.21,
        true,
        innerCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
