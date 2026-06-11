import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              // ── Image ──────────────────────────────────────────────
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: FadeInImage.assetNetwork(
                    placeholder: AppImages.coursedefault,
                    image: ongoingCourses.profile,
                    fit: BoxFit.fitWidth,
                    imageErrorBuilder: (context, error, _) =>
                        Image.asset(AppImages.coursedefault, fit: BoxFit.cover),
                  ),
                ),
              ),

              // ── Body ───────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      ongoingCourses.course,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Title
                    Text(
                      ongoingCourses.subName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Instructor row — overflow-safe ─────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 15,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "Instructor: ${ongoingCourses.staffname}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Explore Button ─────────────────────────────────────
              InkWell(
                onTap: () => Get.toNamed(RouteName.sublist),
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
                      text: 'Explore',
                      fcolor: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}