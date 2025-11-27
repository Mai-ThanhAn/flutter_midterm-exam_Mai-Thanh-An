// This is a Flutter screen that demonstrates using Isolate to compute
// the number of digits in a large factorial without blocking the UI.
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class FactorialScreen extends StatefulWidget {
  const FactorialScreen({super.key});

  @override
  State<FactorialScreen> createState() => _FactorialScreenState();
}

class _FactorialScreenState extends State<FactorialScreen> {
  bool _isCalculating = false;
  String _result = "";
  final int _numberToCalculate = 30000; // The number to compute factorial for

  // Function to calculate the number of digits in n!
  // This runs in a separate isolate.
  static String calculateBigFactorialDigitCount(int n) {
    double sum = 0;
    for (int i = 1; i <= n; i++) {
      sum += math.log(i) / math.ln10;
    }

    int digits = sum.floor() + 1;
    return "Số chữ số của $n! là $digits";
  }

  // Function to run the computation in an isolate
  Future<void> _runComputation() async {
    setState(() {
      _isCalculating = true;
      _result = "Đang tính toán $_numberToCalculate!... (Máy sẽ không bị đơ)";
    });

    try {
      // Use compute to run the heavy calculation in a separate isolate
      // This prevents blocking the main UI thread
      final output = await compute(
        calculateBigFactorialDigitCount,
        _numberToCalculate,
      );

      if (mounted) {
        setState(() {
          _isCalculating = false;
          _result = output;
        });
      }
    } catch (e) {
      setState(() {
        _isCalculating = false;
        _result = "Lỗi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text(
          "Isolate (Factorial)",
          style: TextStyle(color: AppColors.secondaryText),
        ),
        backgroundColor: AppColors.themePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.calculate,
              size: 80,
              color: AppColors.themePrimary,
            ),
            const SizedBox(height: 20),
            Text(
              "Tính giai thừa của $_numberToCalculate",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Đây là tác vụ rất nặng. Nếu không dùng Isolate, ứng dụng sẽ bị treo.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            if (_isCalculating)
              const Center(child: CircularProgressIndicator())
            else
              ElevatedButton.icon(
                onPressed: _runComputation,
                label: const Text(
                  "Bắt đầu tính",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themePrimary,
                  foregroundColor: AppColors.secondaryText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Section to display the result
            // Using Flexible to avoid overflow when text is long
            Flexible(
              fit: FlexFit.loose, // sẽ không ép container chiếm hết chiều cao
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.themePrimary),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _result.isEmpty ? "Kết quả sẽ hiện ở đây" : _result,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
