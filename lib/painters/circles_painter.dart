import 'package:flutter/material.dart';

class CirclesPainter extends CustomPainter {
  final Color baseColor;

  CirclesPainter(this.baseColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = baseColor.withOpacity(0.2);

    List<Offset> centers = [
      Offset(size.width / 5, size.height / 2),
      Offset(size.width * 0.8, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.9),
    ];
    final maxRadius =
        size.width < size.height ? size.width / 2 : size.height / 2;

    for (int i = 0; i < centers.length; i++) {
      canvas.drawCircle(
        centers[i],
        maxRadius * (1 / 5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
