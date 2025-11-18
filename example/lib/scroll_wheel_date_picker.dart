import 'package:flutter/material.dart';

import 'src/widgets/curve_highlight_date_picker.dart';
import 'src/widgets/flat_highlight_date_picker.dart';
import 'src/widgets/curve_line_date_picker.dart';
import 'src/widgets/curve_holo_date_picker.dart';
import 'src/widgets/flat_holo_date_picker.dart';
import 'src/widgets/flat_line_date_picker.dart';
import 'src/widgets/month_year_picker.dart';
import 'src/widgets/year_only_picker.dart';
import 'src/widgets/simple_month_year_picker.dart';
import 'src/widgets/same_day_picker.dart';

class ScrollWheelDatePicker extends StatelessWidget {
  const ScrollWheelDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Scroll Wheel Date Picker",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  "📅 Picker Modes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SimpleMonthYearPicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Month-Year Picker (简化版)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const MonthYearPicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Month-Year Picker (Holo)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const YearOnlyPicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Year Only Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SameDayPicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "同一天选择测试",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Divider(thickness: 2),
                const SizedBox(height: 20.0),
                const Text(
                  "Curve Scroll Wheel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CurveHoloDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Curve Holo Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CurveHighlightDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Curve Highlight Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CurveLineDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Curve Line Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  "Flat Scroll Wheel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FlatHoloDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Flat Holo Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FlatHighlightDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Flat Highlight Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const FlatLineDatePicker();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Flat Line Date Picker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
