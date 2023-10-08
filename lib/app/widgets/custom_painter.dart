import 'package:flutter/material.dart';

class Custompaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.1396876);
    path_0.cubicTo(0, size.height * 0.08647048, 0, size.height * 0.05986186,
        size.width * 0.01523299, size.height * 0.04081907);
    path_0.cubicTo(
        size.width * 0.02865280,
        size.height * 0.02404312,
        size.width * 0.04989369,
        size.height * 0.01111328,
        size.width * 0.07529813,
        size.height * 0.004256153);
    path_0.cubicTo(
        size.width * 0.1041353,
        size.height * -0.003527479,
        size.width * 0.1411855,
        size.height * 0.0005277745,
        size.width * 0.2152862,
        size.height * 0.008638292);
    path_0.cubicTo(
        size.width * 0.3217056,
        size.height * 0.02028607,
        size.width * 0.3749136,
        size.height * 0.02610995,
        size.width * 0.4283949,
        size.height * 0.02844113);
    path_0.cubicTo(
        size.width * 0.4760864,
        size.height * 0.03051990,
        size.width * 0.5239136,
        size.height * 0.03051990,
        size.width * 0.5716051,
        size.height * 0.02844113);
    path_0.cubicTo(
        size.width * 0.6250864,
        size.height * 0.02610995,
        size.width * 0.6782944,
        size.height * 0.02028607,
        size.width * 0.7847126,
        size.height * 0.008638292);
    path_0.cubicTo(
        size.width * 0.8588154,
        size.height * 0.0005277761,
        size.width * 0.8958645,
        size.height * -0.003527479,
        size.width * 0.9247009,
        size.height * 0.004256153);
    path_0.cubicTo(
        size.width * 0.9501075,
        size.height * 0.01111328,
        size.width * 0.9713481,
        size.height * 0.02404312,
        size.width * 0.9847664,
        size.height * 0.04081907);
    path_0.cubicTo(size.width, size.height * 0.05986186, size.width,
        size.height * 0.08647048, size.width, size.height * 0.1396876);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.1396876);
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withAlpha(240);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
