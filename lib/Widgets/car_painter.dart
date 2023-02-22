import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CarPainter extends CustomPaint {
  CarPainter(this.label, this.image);
  final String label;
  final ui.Image image;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(20));
    canvas.drawImage(image, Offset(100, 0.0), paint);
    paint.color = Colors.blueAccent;
    canvas.drawRRect(rRect, paint);
    final textPainter = TextPainter(
        text: TextSpan(
            text: this.label,
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width - 50);
    textPainter.paint(
        canvas, Offset(20, size.height / 2 - textPainter.size.height / 2));
  }

  @override
  bool shoulRepaint(CustomPainter oldelegate) => false;
}
