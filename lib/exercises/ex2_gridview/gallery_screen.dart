import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of 12 image paths in assets/images/
    final List<String> images = List.generate(
        12, (index) => 'assets/images/ex2/${index + 1}.jpg');

    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text("Grid View Gallery",
            style: TextStyle(color: AppColors.secondaryText)),
        backgroundColor: AppColors.themePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GridView.count Section
            const Text(
              "Fixed Column Grid (GridView.count)",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: images.map((path) => _buildGridItem(path)).toList(),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            // GridView.extent Section
            const Text(
              "Responsive Grid (GridView.extent)",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
            ),
            const Text(
              "(Columns adjust according to screen width)",
              style: TextStyle(fontSize: 14, color: AppColors.primaryText),
            ),
            const SizedBox(height: 10),

            GridView.extent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: images
                  .map((path) => _buildGridItem(path, isResponsive: true))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Build each grid item with an image
  Widget _buildGridItem(String imagePath, {bool isResponsive = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getColorByIndex(
            imagePath.hashCode, // index-based color
            opacity: 0.3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}