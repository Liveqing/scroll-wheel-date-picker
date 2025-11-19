import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/theme_constants.dart';

class HightlightOverlay extends StatelessWidget {
  /// Creates a rounded rectangle background with the default [CupertinoContextMenu.kOpenBorderRadius] radius.
  const HightlightOverlay({
    super.key,
    required this.height,
    this.color,
    this.margin,
  });

  /// Actual height of the [HightlightOverlay].
  final double height;

  /// Background color.
  final Color? color;

  /// Horizontal margin around the overlay. Defaults to [defaultModeMargin] if not specified.
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin ?? defaultModeMargin),
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withOpacity(defaultOpacity),
        borderRadius:
            BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
      ),
    );
  }
}
