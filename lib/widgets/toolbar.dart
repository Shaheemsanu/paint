import 'package:flutter/material.dart';
import '../models/shape_model.dart';
import 'input_box.dart';

class PaintToolbar extends StatelessWidget {
  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  final VoidCallback onApply;
  final Function(ShapeType) onAddShape;
  final VoidCallback? onDelete;

  const PaintToolbar({
    super.key,
    required this.widthCtrl,
    required this.heightCtrl,
    required this.onApply,
    required this.onAddShape,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          InputBox(controller: widthCtrl, label: "Width px"),
          InputBox(controller: heightCtrl, label: "Height px"),
          ElevatedButton(onPressed: onApply, child: const Text("Apply")),

          Card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.crop_square),
                  onPressed: () => onAddShape(ShapeType.rectangle),
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  onPressed: () => onAddShape(ShapeType.circle),
                ),
                IconButton(
                  icon: const Icon(Icons.hexagon),
                  onPressed: () => onAddShape(ShapeType.hexagon),
                ),
                IconButton(
                  icon: const Icon(Icons.show_chart),
                  onPressed: () => onAddShape(ShapeType.line),
                ),
                IconButton(
                  icon: const Icon(Icons.change_history),
                  onPressed: () => onAddShape(ShapeType.triangle),
                ),
                IconButton(
                  icon: const Icon(Icons.rounded_corner),
                  onPressed: () => onAddShape(ShapeType.roundedRect),
                ),
              ],
            ),
          ),

          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
