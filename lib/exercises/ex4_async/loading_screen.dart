// This is a Flutter code snippet demonstrating asynchronous data loading with a loading screen.
import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Variables to hold loading state and message
  String _message = "Tải dữ liệu người dùng...";
  // State variable to track loading status
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mockLoadData();
  }

  //Asynchronous
  Future<void> _mockLoadData() async {
    // Future.delayed is used to simulate a network call or data loading
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // After the delay, update the state
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        _isLoading = false; // Disable loading state
        _message = "Thông tin đã tải thành công!"; // Change message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text("Async Demo", style: TextStyle(color: AppColors.secondaryText)),
        backgroundColor: AppColors.themePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show loading indicator or success icon
            // If loading, show CircularProgressIndicator
            // If not loading, show a check icon
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _isLoading ? Colors.white : AppColors.primaryText,
                shape: BoxShape.circle,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(strokeWidth: 3)
                  : const Icon(Icons.check, size: 50, color: AppColors.secondaryText),
            ),

            const SizedBox(height: 24),

            // Show message text
            Text(
              _message,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isLoading ? AppColors.primaryText : AppColors.primaryText,
              ),
            ),

            const SizedBox(height: 40),

            // Reset button to reload data
            if (!_isLoading)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _message = "Tải dữ liệu người dùng...";
                  });
                  _mockLoadData();
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Tải lại"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themePrimary,
                    foregroundColor: AppColors.secondaryText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
