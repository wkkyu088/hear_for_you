import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';

class WaveForm extends CustomPainter {
  final double height;
  final double opacity;

  WaveForm(this.height, this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white.withOpacity(opacity);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = height == 1 ? 2.5 : 2;

    var path = Path();
    var w = size.width;
    var h = size.height * height;

    List nodes = [
      [w / 12 * 1, h / 8 * 2],
      [w / 12 * 2, h / 8 * 6],
      [w / 12 * 3, h / 8 * 3],
      [w / 12 * 4, h / 8 * 5],
      [w / 12 * 5, h / 8 * 0.1],
      [w / 12 * 6, h / 8 * 8],
      [w / 12 * 7, h / 8 * 2],
      [w / 12 * 8, h / 8 * 5],
      [w / 12 * 9, h / 8 * 4],
      [w / 12 * 10, h / 8 * 6],
      [w / 12 * 11, h / 8 * 3.5],
      [w / 12 * 12, h / 8 * 4],
    ];

    path.moveTo(0, h * 0.5);
    regularValue
        ? {
            for (int i = 0; i < 11; i++)
              {
                path.quadraticBezierTo(
                    nodes[i][0],
                    nodes[i][1],
                    (nodes[i][0] + nodes[i + 1][0]) / 2,
                    (nodes[i][1] + nodes[i + 1][1]) / 2)
              }
          }
        : null;
    path.lineTo(w, h * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
