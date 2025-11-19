import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomMarginPicker extends StatefulWidget {
  const CustomMarginPicker({super.key});

  @override
  State<CustomMarginPicker> createState() => _CustomMarginPickerState();
}

class _CustomMarginPickerState extends State<CustomMarginPicker> {
  double _margin = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "自定义 Overlay 边距",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ScrollWheelDatePicker(
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.grey[900]!,
                  overlay: ScrollWheelDatePickerOverlay.highlight,
                  overlayMargin: _margin,
                  itemTextStyle: defaultItemTextStyle,
                  monthFormat: MonthFormat.threeLetters,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    'Overlay 边距: ${_margin.toStringAsFixed(0)} px',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    value: _margin,
                    min: 0,
                    max: 50,
                    divisions: 50,
                    activeColor: Colors.blueAccent,
                    inactiveColor: Colors.grey[700],
                    label: _margin.toStringAsFixed(0),
                    onChanged: (value) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _margin = value;
                        });
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '拖动滑块以调整 Highlight Overlay 的左右边距',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

