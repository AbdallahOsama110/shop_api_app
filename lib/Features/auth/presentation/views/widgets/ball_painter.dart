import 'package:flutter/material.dart';

class BallPainter extends CustomPainter {
  final double radius;

  BallPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(colors: [
        Colors.deepPurple,
        Colors.deepPurple,
        Colors.purple,
        Color(0xffCA4C8F),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
