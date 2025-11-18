import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Example of a year-only picker using ScrollWheelDatePicker
/// This demonstrates the yearOnly mode which displays only year selection
class YearOnlyPicker extends StatefulWidget {
  const YearOnlyPicker({super.key});

  @override
  State<YearOnlyPicker> createState() => _YearOnlyPickerState();
}

class _YearOnlyPickerState extends State<YearOnlyPicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Year Picker",
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
            // Display selected year
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Selected Year: ${_selectedDate!.year}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            
            // Date picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ScrollWheelDatePicker(
                startDate: DateTime(1950, 1, 1),
                lastDate: DateTime(2050, 12, 31),
                initialDate: DateTime.now(),
                mode: ScrollWheelDatePickerMode.yearOnly,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedDate = date;
                    });
                  });
                },
                theme: CurveDatePickerTheme(
                  overlay: ScrollWheelDatePickerOverlay.highlight,
                  itemTextStyle: defaultItemTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  overlayColor: Colors.blueAccent.withOpacity(0.2),
                  overAndUnderCenterOpacity: 0.4,
                  diameterRatio: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

