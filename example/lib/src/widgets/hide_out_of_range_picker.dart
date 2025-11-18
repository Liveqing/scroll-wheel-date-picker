import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';

/// 测试hideOutOfRange参数的示例
/// 演示隐藏超出范围日期的效果
class HideOutOfRangePicker extends StatefulWidget {
  const HideOutOfRangePicker({super.key});

  @override
  State<HideOutOfRangePicker> createState() => _HideOutOfRangePickerState();
}

class _HideOutOfRangePickerState extends State<HideOutOfRangePicker> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "隐藏超出范围日期测试",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // 说明
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Column(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    '对比测试',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'lastDate 设置为今天（${_today.month}月${_today.day}日）\n两个选择器的区别：',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '上方：hideOutOfRange = false（默认）\n显示所有日期，超出的置灰不可选',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '下方：hideOutOfRange = true\n只显示可选日期，超出的完全不显示',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 第一个选择器：hideOutOfRange = false（默认）
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.visibility, color: Colors.grey, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'hideOutOfRange = false（默认）',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            // 显示选择的日期1
            if (_selectedDate1 != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '已选: ${_selectedDate1!.year}-${_selectedDate1!.month.toString().padLeft(2, '0')}-${_selectedDate1!.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              child: ScrollWheelDatePicker(
                startDate: DateTime(2020, 1, 1),
                initialDate: _today,
                lastDate: _today, // 只能选择到今天
                hideOutOfRange: false, // 默认：显示所有日期
                loopDays: false,
                loopMonths: false,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  setState(() {
                    _selectedDate1 = date;
                  });
                },
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.white,
                  overlay: ScrollWheelDatePickerOverlay.holo,
                  itemTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overlayColor: Colors.grey,
                  overAndUnderCenterOpacity: 0.4,
                  monthFormat: MonthFormat.threeLetters,
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '👆 可以看到本月所有日期，但今天之后的日期置灰不可选',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 40),
            const Divider(thickness: 2, indent: 20, endIndent: 20),
            const SizedBox(height: 30),

            // 第二个选择器：hideOutOfRange = true
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.visibility_off, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'hideOutOfRange = true',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            // 显示选择的日期2
            if (_selectedDate2 != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '已选: ${_selectedDate2!.year}-${_selectedDate2!.month.toString().padLeft(2, '0')}-${_selectedDate2!.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                  ),
                ),
              ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              child: ScrollWheelDatePicker(
                startDate: DateTime(2020, 1, 1),
                initialDate: _today,
                lastDate: _today, // 只能选择到今天
                hideOutOfRange: true, // 隐藏超出范围的日期
                loopDays: false,
                loopMonths: false,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  setState(() {
                    _selectedDate2 = date;
                  });
                },
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.white,
                  overlay: ScrollWheelDatePickerOverlay.holo,
                  itemTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overlayColor: Colors.orange,
                  overAndUnderCenterOpacity: 0.4,
                  monthFormat: MonthFormat.threeLetters,
                ),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '👆 只显示1-${_today.day}号，今天之后的日期完全不显示 ✨',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

