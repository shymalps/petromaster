import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/categoryvm.dart';
import 'coursecard.dart';

class CourseGrids extends StatelessWidget {
  const CourseGrids({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryVM = Get.find<CategoryVM>();

    return Obx(() {
      if (categoryVM.isLoading.value) {
        return _buildShimmerEffect();
      } else {
        return _buildCourseGrid(categoryVM, categoryVM.selectedCategory.value);
      }
    });
  }

Widget _buildCourseGrid(CategoryVM categoryVM, String selectedCategory) {
  return SizedBox(
    height: 260, // VERY IMPORTANT
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          categoryVM.courseList.length,
          (index) {
            if (selectedCategory.isNotEmpty &&
                selectedCategory != "All" &&
                categoryVM.courseList[index].subName != selectedCategory) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CourseCard(
                courseListModel: categoryVM.courseList[index],
              ),
            );
          },
        ).where((widget) => widget is! SizedBox).toList(),
      ),
    ),
  );
}

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: Row(
        
        children: List.generate(
          4, // Show 4 shimmer placeholders
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 200, // Match your CourseCard width
                height: 240, // Match your CourseCard height
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              
            ),
          ),
        ),
        
      ),
    );
  }
}
