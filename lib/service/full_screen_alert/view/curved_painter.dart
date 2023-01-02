import 'package:flutter/material.dart';

// 알림 화면 배경
class CurvedPainter extends CustomPainter {
  final double point;
  final double height;
  final Offset center;
  final Color color;

  CurvedPainter(this.center, this.point, this.height, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * height);
    path.quadraticBezierTo(size.width * point, size.height * (height + 0.15),
        size.width, size.height * height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
