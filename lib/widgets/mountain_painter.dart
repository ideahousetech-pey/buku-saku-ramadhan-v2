import 'package:flutter/material.dart';

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green.shade900;
    final path = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.25, size.height * 0.25)
      ..lineTo(size.width * 0.5, size.height * 0.45)
      ..lineTo(size.width * 0.75, size.height * 0.3)
      ..lineTo(size.width, size.height * 0.45)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
