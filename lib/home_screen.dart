// This is a starter screen for the midterm exam app.
import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: AppColors.themePrimary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BÀI TẬP GIỮA KỲ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryText,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Mai Thanh An - 2224801030406",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMenuItem(
                  context,
                  title: "Bài 1: List View (Contacts)",
                  icon: Icons.list_alt,
                  route: '/ex1',
                ),
                _buildMenuItem(
                  context,
                  title: "Bài 2: Grid View (Gallery)",
                  icon: Icons.grid_view,
                  route: '/ex2',
                ),
                _buildMenuItem(
                  context,
                  title: "Bài 3: Shared Preferences",
                  icon: Icons.save_rounded,
                  route: '/ex3',
                ),
                _buildMenuItem(
                  context,
                  title: "Bài 4: Async Loading",
                  icon: Icons.downloading_rounded,
                  route: '/ex4',
                ),
                _buildMenuItem(
                  context,
                  title: "Bài 5: Isolate (Factorial)",
                  icon: Icons.calculate_rounded,
                  route: '/ex5',
                ),

                const SizedBox(height: 10),
                const Divider(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.themePrimary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 3),
                        color: AppColors.secondaryText,
                      ),
                    ],
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.terminal, color: AppColors.secondaryText),
                    title: Text(
                      "Bài 5 - Challenge 2",
                      style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.secondaryText),
                    ),
                    subtitle: Text("Chạy file trong thư mục bin/ bằng terminal", style: TextStyle(color: AppColors.secondaryText)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Menu item widget builder receiving title, icon, and route name
  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
  }) {
    // Gesture is used to detect taps
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryText, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.primaryText),
          ],
        ),
      ),
    );
  }
}