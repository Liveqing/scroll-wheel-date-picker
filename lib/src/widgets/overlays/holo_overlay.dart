import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class HoloOverlay extends StatelessWidget {
  /// Create a horizontal parallel lines separated with a space.
  const HoloOverlay({
    super.key,
    required this.height,
    this.color,
    this.wheelCount = 3,
  });

  /// Gap between the lines of [HoloOverlay].
  final double height;

  /// Lines color.
  final Color? color;

  /// Number of wheels to display (1, 2, or 3).
  final int wheelCount;

  /// Builds a single wheel border container.
  Widget _buildWheelBorder() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color ?? Colors.white,
              width: defaultModeBorderThickness,
            ),
            bottom: BorderSide(
              color: color ?? Colors.white,
              width: defaultModeBorderThickness,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    
    for (int i = 0; i < wheelCount; i++) {
      if (i > 0) {
        children.add(const SizedBox(width: defaultModeSpacing));
      }
      children.add(_buildWheelBorder());
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultModeMargin),
      height: height,
      child: Row(
        children: children,
      ),
    );
  }
}
