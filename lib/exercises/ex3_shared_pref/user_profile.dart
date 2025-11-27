import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:midterm_exam/utils/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Controllers for text fields
  // Name is required, Email and Age are optional
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Variable to display loaded data
  String _displayData = "Chưa có dữ liệu";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  //Function 1 : SAVE DATA
  Future<void> _saveData() async {
    // 1. Get instance from SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // 2. Get data from input fields
    String name = _nameController.text;
    String email = _emailController.text;
    String age = _ageController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vui lòng nhập tên!")));
      return;
    }

    // 3. Save data with specific keys
    await prefs.setString('user_name', name);
    if (email.isNotEmpty) await prefs.setString('user_email', email);
    if (age.isNotEmpty) await prefs.setInt('user_age', int.tryParse(age) ?? 0);

    // Save timestamp
    String timestamp = DateTime.now().toIso8601String();
    await prefs.setString('last_saved', timestamp);

    // Success message using SnackBar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đã lưu dữ liệu thành công!")),
      );
      // Clear input fields
      _nameController.clear();
      _emailController.clear();
      _ageController.clear();
    }
  }

  //Function 2: LOAD DATA
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Get data by keys
    String? name = prefs.getString('user_name');
    String? email = prefs.getString('user_email');
    int? age = prefs.getInt('user_age');
    String? timestamp = prefs.getString('last_saved');

    setState(() {
      if (name != null) {
        // Format timestamp
        String timeStr = "";
        if (timestamp != null) {
          DateTime time = DateTime.parse(timestamp);
          timeStr = DateFormat('HH:mm:ss dd/MM/yyyy').format(time);
        }

        _displayData =
            "Thông tin đã lưu:\n\n"
            "Tên: $name\n"
            "Email: ${email ?? 'Chưa nhập'}\n"
            "Tuổi: ${age != 0 ? age : 'Chưa nhập'}\n"
            "Lưu lúc: $timeStr";
      } else {
        _displayData = "Không tìm thấy dữ liệu nào!";
      }
    });
  }

  //Function 3: CLEAR DATA
  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    // Clear all saved data using await because it's async operation
    await prefs.clear();

    setState(() {
      _displayData = "Dữ liệu đã được xóa sạch.";
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        // Using SnackBar to notify user
        const SnackBar(content: Text("Đã xóa bộ nhớ đệm!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text(
          "Shared Preferences",
          style: TextStyle(color: AppColors.secondaryText),
        ),
        backgroundColor: AppColors.themePrimary,
      ),
      // Using SingleChildScrollView to avoid overflow when keyboard appears
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Nhập thông tin cá nhân",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 15),

            // Name input field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                labelText: "Họ và Tên",
                labelStyle: TextStyle(color: AppColors.themePrimary),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themePrimary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.person, color: AppColors.themePrimary),
              ),
            ),
            const SizedBox(height: 10),

            // Email input field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                labelText: "Email",
                labelStyle: TextStyle(color: AppColors.themePrimary),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themePrimary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.email, color: AppColors.themePrimary),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),

            // Age input field
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFFFFFFF),
                labelText: "Tuổi",
                labelStyle: TextStyle(color: AppColors.themePrimary),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.themePrimary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: Icon(Icons.cake, color: AppColors.themePrimary),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _saveData,
                  label: const Text("Lưu"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themePrimary,
                    foregroundColor: AppColors.secondaryText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _loadData,
                  label: const Text("Xem"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themePrimary,
                    foregroundColor: AppColors.secondaryText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _clearData,
                  label: const Text("Xóa"),
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

            const SizedBox(height: 30),
            const Divider(thickness: 2, color: AppColors.themePrimary),
            const SizedBox(height: 10),

            // Section to display loaded data from SharedPreferences
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.themePrimary),
              ),
              child: Text(
                _displayData,
                style: const TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
