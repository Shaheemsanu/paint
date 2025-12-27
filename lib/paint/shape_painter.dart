import 'package:flutter/material.dart';
import '../models/shape_model.dart';

class ShapePainter extends CustomPainter {
  final Shape shape;
  final bool selected;

  ShapePainter(this.shape, this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()..color = Colors.orange;
    final border = Paint()
      ..color = selected ? Colors.blue : Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    switch (shape.type) {
      case ShapeType.rectangle:
        canvas.drawRect(Offset.zero & size, fill);
        canvas.drawRect(Offset.zero & size, border);
        break;

      case ShapeType.circle:
        canvas.drawOval(Offset.zero & size, fill);
        canvas.drawOval(Offset.zero & size, border);
        break;

      case ShapeType.hexagon:
        final p = Path()
          ..moveTo(size.width * .25, 0)
          ..lineTo(size.width * .75, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width * .75, size.height)
          ..lineTo(size.width * .25, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
        canvas.drawPath(p, fill);
        canvas.drawPath(p, border);
        break;

      case ShapeType.triangle:
        final p = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..close();
        canvas.drawPath(p, fill);
        canvas.drawPath(p, border);
        break;

      case ShapeType.line:
        canvas.drawLine(
          Offset.zero,
          Offset(size.width, size.height),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 4,
        );
        break;

      case ShapeType.roundedRect:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Offset.zero & size,
            const Radius.circular(12),
          ),
          fill,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
