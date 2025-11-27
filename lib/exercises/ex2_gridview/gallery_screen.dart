// Gallery Screen demonstrating GridView.count and GridView.extent
// GridView.count using for fixed column layout
// GridView.extent using for responsive layout
import 'package:flutter/material.dart';
import 'package:midterm_exam/utils/constants.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 12 items to display in the grid
    final List<int> items = List.generate(12, (index) => index + 1);

    return Scaffold(
      backgroundColor: AppColors.themeSecondary,
      appBar: AppBar(
        title: const Text("Grid View Gallery", style: TextStyle(color: AppColors.secondaryText)),
        backgroundColor: AppColors.themePrimary,
      ),
      // using SingleChildScrollView to allow vertical scrolling bcs of 2 GridViews
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GridView.count Section [using fixed number of columns]
            const Text(
              "Fixed Column Grid (GridView.count)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
            ),
            const SizedBox(height: 10),

            // Parameter configuration for GridView.count following documentation
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,

              // Config to avoid unbounded height error inside Column
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              children: items.map((item) => _buildGridItem(item)).toList(),
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),

            // GridView.extent Section [using responsive column layout]
            const Text(
              "Responsive Grid (GridView.extent)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryText),
            ),
            const Text(
              "(Co giãn số cột tùy theo màn hình)",
              style: TextStyle(fontSize: 14, color: AppColors.primaryText),
            ),
            const SizedBox(height: 10),

            GridView.extent(
              // maxCrossAxisExtent defines the maximum width of each item
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              children: items
                  .map((item) => _buildGridItem(item, isResponsive: true))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Fuction to build each grid item widget
  Widget _buildGridItem(int index, {bool isResponsive = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.primaries[index % Colors.primaries.length].withOpacity(
          0.7,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isResponsive ? Icons.photo_size_select_large : Icons.image,
            size: 32,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            "Item $index",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
