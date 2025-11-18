import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

/// 测试同一天选择的示例
/// 验证 startDate, initialDate, lastDate 可以是同一天
class SameDayPicker extends StatefulWidget {
  const SameDayPicker({super.key});

  @override
  State<SameDayPicker> createState() => _SameDayPickerState();
}

class _SameDayPickerState extends State<SameDayPicker> {
  DateTime? _selectedDate;
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "同一天选择测试",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 说明文字
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.purple, size: 32),
                    const SizedBox(height: 8),
                    const Text(
                      '测试场景',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'startDate、initialDate 和 lastDate\n都设置为今天（${_today.year}-${_today.month}-${_today.day}）',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // 显示选择的日期
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      '选择的日期',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedDate != null
                          ? '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}'
                          : '未选择',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 日期选择器 - startDate, initialDate, lastDate 都是今天
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
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                padding: const EdgeInsets.all(16.0),
                child: ScrollWheelDatePicker(
                  startDate: _today, // 今天
                  initialDate: _today, // 今天
                  lastDate: _today, // 今天
                  mode: ScrollWheelDatePickerMode.dayMonthYear,
                  loopDays: false,
                  loopMonths: false,
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
                    overlayColor: Colors.purple.withOpacity(0.2),
                    overAndUnderCenterOpacity: 0.4,
                    monthFormat: MonthFormat.full,
                  ),
                ),
              ),

              // 成功提示
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      '✅ 允许选择同一天！',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

