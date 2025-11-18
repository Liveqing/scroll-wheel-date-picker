import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

/// 简化的月份-年份选择器示例
/// 用于调试和确认只显示2个滚轮
class SimpleMonthYearPicker extends StatefulWidget {
  const SimpleMonthYearPicker({super.key});

  @override
  State<SimpleMonthYearPicker> createState() => _SimpleMonthYearPickerState();
}

class _SimpleMonthYearPickerState extends State<SimpleMonthYearPicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "简化月份-年份选择器",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 显示选择的日期
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      '当前选择',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedDate != null
                          ? '${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year}'
                          : '未选择',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              // 日期选择器 - 只显示月份和年份（2个滚轮）
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(16.0),
                child: ScrollWheelDatePicker(
                  startDate: DateTime(2020, 1, 1),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  mode: ScrollWheelDatePickerMode.monthYear, // 只显示月份和年份
                  loopMonths: true,
                  loopYears: false,
                  onSelectedItemChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  theme: FlatDatePickerTheme(
                    backgroundColor: Colors.white,
                    overlay: ScrollWheelDatePickerOverlay.highlight,
                    itemTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overlayColor: Colors.green,
                    overAndUnderCenterOpacity: 0.4,
                    monthFormat: MonthFormat.threeLetters, // 使用3字母缩写
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                '应该只显示2个滚轮：月份和年份',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
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

