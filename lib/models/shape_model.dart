import 'package:flutter/material.dart';

enum ShapeType {
  rectangle,
  circle,
  hexagon,
  line,
  triangle,
  roundedRect,
}

class Shape {
  ShapeType type;
  Offset position;
  Size size;

  Shape({
    required this.type,
    required this.position,
    required this.size,
  });
}
