import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 测试超出时间日期范围的示例
/// 最小时间：2024年12月24日
/// 最大时间：2025年12月25日
class DateRangeTestPicker extends StatefulWidget {
  const DateRangeTestPicker({super.key});

  @override
  State<DateRangeTestPicker> createState() => _DateRangeTestPickerState();
}

class _DateRangeTestPickerState extends State<DateRangeTestPicker> {
  DateTime? _selectedDate1;
  DateTime? _selectedDate2;
  
  // 定义日期范围
  final DateTime _startDate = DateTime(2024, 12, 24);
  final DateTime _lastDate = DateTime(2025, 12, 25);
  final DateTime _initialDate = DateTime(2025, 1, 1); // 初始日期设为2025年1月1日

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "超出时间日期范围测试",
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
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple, width: 2),
              ),
              child: const Column(
                children: [
                  Icon(Icons.date_range, color: Colors.deepPurple, size: 32),
                  SizedBox(height: 8),
                  Text(
                    '日期范围测试',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '最小时间：2024年12月24日\n最大时间：2025年12月25日\n初始日期：2025年1月1日',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '测试目的：验证日期选择器在跨年范围内的正确性',
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
                    'hideOutOfRange = false（显示所有日期）',
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
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '已选择: ${_selectedDate1!.year}年${_selectedDate1!.month}月${_selectedDate1!.day}日',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
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
                startDate: _startDate,
                initialDate: _initialDate,
                lastDate: _lastDate,
                hideOutOfRange: false, // 默认：显示所有日期
                loopDays: false,
                loopMonths: false,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedDate1 = date;
                    });
                  });
                },
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.white,
                  overlay: ScrollWheelDatePickerOverlay.highlight,
                  itemTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overlayColor: Colors.grey.withOpacity(0.2),
                  overAndUnderCenterOpacity: 0.4,
                  monthFormat: MonthFormat.full,
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '👆 显示全部月份和日期\n超出范围的日期置灰不可选',
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
                  Icon(Icons.visibility_off, color: Colors.deepPurple, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'hideOutOfRange = true（隐藏超出范围）',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
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
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '已选择: ${_selectedDate2!.year}年${_selectedDate2!.month}月${_selectedDate2!.day}日',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              child: ScrollWheelDatePicker(
                startDate: _startDate,
                initialDate: _initialDate,
                lastDate: _lastDate,
                hideOutOfRange: true, // 隐藏超出范围的日期
                loopDays: false,
                loopMonths: false,
                loopYears: false,
                onSelectedItemChanged: (date) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _selectedDate2 = date;
                    });
                  });
                },
                theme: FlatDatePickerTheme(
                  backgroundColor: Colors.white,
                  overlay: ScrollWheelDatePickerOverlay.highlight,
                  itemTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overlayColor: Colors.deepPurple.withOpacity(0.2),
                  overAndUnderCenterOpacity: 0.4,
                  monthFormat: MonthFormat.full,
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '👆 只显示可选范围内的日期\n2024年只显示12月24-31日\n2025年只显示1-12月（12月只到25日）',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 测试要点说明
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber, width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.amber, size: 24),
                      SizedBox(width: 8),
                      Text(
                        '测试要点',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    '✓ 跨年日期范围处理\n'
                    '✓ 月份边界正确性（2024年12月、2025年12月）\n'
                    '✓ 日期边界正确性（24日开始、25日结束）\n'
                    '✓ hideOutOfRange 参数效果对比\n'
                    '✓ 初始日期在范围内的正确显示',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

