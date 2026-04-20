import 'package:petromaster/presentation/shared/view/nodatafound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/app/config/theme/colors.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';
import '../../viewmodel/examlistvm.dart';
import 'src/listitem.dart';

class Examlist extends StatelessWidget {
  const Examlist({super.key});

  @override
  Widget build(BuildContext context) {
    final examlistVM = Get.find<Examlistvm>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return examlistVM.getExamslist();
        },
        child: Obx(
          () => CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: Di.screenWidth * 0.4,
                expandedHeight: Di.screenWidth * 0.4,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16, left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextHelper.subHead(
                              text: 'Track your progress',
                              fcolor: Colors.white),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 38,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildFilterChip('All'),
                                  _buildFilterChip('Upcoming'),
                                  _buildFilterChip('Completed'),
                                  _buildFilterChip('Missed'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: Di.screenWidth * 0.02),
              //     child: AppTextHelper.caption(
              //         text: '${examlistVM.examlist.length} exams found',
              //         fcolor: const Color(0xFF6B7280)),
              //   ),
              // ),
              examlistVM.examlist.isEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return const Center(child: Emptypage());
                        },
                        childCount: 1,
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final exam = examlistVM.examlist[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Di.screenWidth * 0.02),
                            child: (examlistVM.activeFilter.value ==
                                    examlistVM
                                        .getexamstatusbyfilter(exam.button))
                                ? ExamCard(
                                    exam: exam,
                                    onTap: () => examlistVM.navigation(
                                        exam.button, exam.examId),
                                  )
                                : const SizedBox.shrink(),
                          );
                        },
                        childCount: examlistVM.examlist.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String text) {
    final examlistVM = Get.find<Examlistvm>();
    final isSelected = examlistVM.activeFilter.value == text;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            examlistVM.updateActiveFilter(text);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.1),
                      ],
                    )
                  : null,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
