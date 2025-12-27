import 'package:custom_paint/paint/shape_painter.dart';
import 'package:flutter/material.dart';
import '../models/shape_model.dart';

class ShapeWidget extends StatelessWidget {
  final Shape shape;
  final bool selected;
  final VoidCallback onTap;
  final Function(DragUpdateDetails) onMove;
  final Function(DragUpdateDetails) onResize;

  const ShapeWidget({
    super.key,
    required this.shape,
    required this.selected,
    required this.onTap,
    required this.onMove,
    required this.onResize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: shape.position.dx,
      top: shape.position.dy,
      child: GestureDetector(
        onTap: onTap,
        onPanUpdate: onMove,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (selected)
              Positioned(
                top: -20,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.black,
                  child: Text(
                    "${shape.size.width.round()} × ${shape.size.height.round()}",
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            CustomPaint(size: shape.size, painter: ShapePainter(shape, selected)),
            if (selected)
              Positioned(
                right: 4,
                bottom: 4,
                child: GestureDetector(
                  onPanUpdate: onResize,
                  child: Container(width: 14, height: 14, color: Colors.blue),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
