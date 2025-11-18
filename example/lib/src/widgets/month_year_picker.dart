import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

/// Example of a month-year picker using ScrollWheelDatePicker
/// This demonstrates the monthYear mode which displays only month and year
class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker({super.key});

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Month-Year Picker",
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
            // Display selected date
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Selected: ${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            
            // Date picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ScrollWheelDatePicker(
                startDate: DateTime(2020, 1, 1),
                lastDate: DateTime(2030, 12, 31),
                initialDate: DateTime.now(),
                mode: ScrollWheelDatePickerMode.monthYear,
                loopMonths: true,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.white,
                  overlay: ScrollWheelDatePickerOverlay.holo,
                  itemTextStyle: defaultItemTextStyle.copyWith(color: Colors.black),
                  overlayColor: Colors.blueAccent,
                  overAndUnderCenterOpacity: 0.3,
                  monthFormat: MonthFormat.full,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}

