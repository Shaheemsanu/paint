import 'package:flutter/material.dart';

import '../models/shape_model.dart';
import '../widgets/toolbar.dart';
import '../widgets/shape_widget.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {

  double canvasWidth = 800;
  double canvasHeight = 450;

  final widthCtrl = TextEditingController(text: "800");
  final heightCtrl = TextEditingController(text: "450");

  final List<Shape> shapes = [];
  Shape? selectedShape;

  static const double minShapeSize = 30;


  void addShape(ShapeType type) {
    setState(() {
      shapes.add(
        Shape(
          type: type,
          position: const Offset(40, 40),
          size: const Size(120, 100),
        ),
      );
    });
  }

  void deleteShape() {
    if (selectedShape == null) return;
    setState(() {
      shapes.remove(selectedShape);
      selectedShape = null;
    });
  }

  void updateCanvas() {
    final w = double.tryParse(widthCtrl.text);
    final h = double.tryParse(heightCtrl.text);

    if (w == null || h == null || w < 200 || h < 200) return;

    for (final s in shapes) {
      if (s.position.dx + s.size.width > w ||
          s.position.dy + s.size.height > h) {
        return;
      }
    }

    setState(() {
      canvasWidth = w;
      canvasHeight = h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Paint App")),
      body: Column(
        children: [
          //TOOLBARS
          PaintToolbar(
            widthCtrl: widthCtrl,
            heightCtrl: heightCtrl,
            onApply: updateCanvas,
            onAddShape: addShape,
            onDelete: selectedShape != null ? deleteShape : null,
          ),

        
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Container(
                    width: canvasWidth,
                    height: canvasHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Stack(
                      children: shapes.map((shape) {
                        final isSelected = shape == selectedShape;

                        return ShapeWidget(
                          shape: shape,
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedShape = shape;
                            });
                          },
                          onMove: (d) {
                            setState(() {
                              shape.position = Offset(
                                (shape.position.dx + d.delta.dx).clamp(
                                  0,
                                  canvasWidth - shape.size.width,
                                ),
                                (shape.position.dy + d.delta.dy).clamp(
                                  0,
                                  canvasHeight - shape.size.height,
                                ),
                              );
                            });
                          },
                          onResize: (d) {
                            setState(() {
                              shape.size = Size(
                                (shape.size.width + d.delta.dx).clamp(
                                  minShapeSize,
                                  canvasWidth - shape.position.dx,
                                ),
                                (shape.size.height + d.delta.dy).clamp(
                                  minShapeSize,
                                  canvasHeight - shape.position.dy,
                                ),
                              );
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widthCtrl.dispose();
    heightCtrl.dispose();
    super.dispose();
  }
}
