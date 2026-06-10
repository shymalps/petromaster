import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

import '../../../../../app/config/routes/route_name.dart';
import '../../../../../app/config/theme/colors.dart';
import '../../../../../app/config/theme/text.dart';
import '../../../../../core/res/assets/images.dart';
import '../../../../../domain/models/coursedetails_model.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.ongoingCourses,
  });

  final Course ongoingCourses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: 300,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              bottom: BorderSide(color: Colors.green, width: 2.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    offset: const Offset(0, 5),
                    blurRadius: 8,
                  ),
                ]),
                child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16), bottom: Radius.circular(16)),
                    child: FadeInImage.assetNetwork(
                      placeholder:
                          AppImages.coursedefault, // Placeholder image path
                      image: ongoingCourses.profile, // URL of the image
                      fit: BoxFit.fitWidth,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppImages.coursedefault, // Fallback asset image path
                          fit: BoxFit.cover,
                        );
                      },
                    )),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      ongoingCourses.course,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Title
                    Text(
                      ongoingCourses.subName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Footer Row
                    // Row(
                    //   children: [
                    //     Text("Instructor: ${ongoingCourses.staffname} "),
                    //     const Spacer(),
                    //   ],
                    // ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteName.sublist);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  width: double.infinity,
                  child: Center(
                      child: AppTextHelper.button(
                          text: 'Explore', fcolor: AppColors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
