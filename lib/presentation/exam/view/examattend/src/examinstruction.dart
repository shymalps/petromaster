import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/presentation/exam/viewmodel/examattendvm.dart';

import '../../../../../app/config/routes/route_name.dart';
import '../../../../../app/config/theme/colors.dart';
import '../../../viewmodel/examattendvm.dart';
import 'examshimmer.dart';

class ExamInstructions extends StatefulWidget {
  const ExamInstructions({
    super.key,
  });

  @override
  ExamInstructionsState createState() => ExamInstructionsState();
}

class ExamInstructionsState extends State<ExamInstructions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final examattendVm = Get.find<Examattendvm>();
    return PopScope(
        canPop: false,
        child: Obx(
          () {
            // Show shimmer while loading
            if (examattendVm.isloading.value) {
              return const ExamScreenShimmer();
            }

            // If examData is null after loading, the exam was already attempted
            // or the API returned an error — show a friendly error screen
            if (examattendVm.examData.value == null) {
              return _buildAlreadyAttemptedScreen(context);
            }

            // Normal instruction screen
            return Scaffold(
                backgroundColor: const Color(0xFFF8FAFF),
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      expandedHeight: 100,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.school_rounded,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _slideAnimation.value),
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Exam Summary Card
                              _buildSummaryCard(
                                  context,
                                  examattendVm
                                      .timeconvert(examattendVm
                                          .examData.value!.totalTime)
                                      .toString(),
                                  examattendVm
                                          .examData.value!.markPerQuestion ??
                                      '',
                                  examattendVm.questions.length.toString()),
                              const SizedBox(height: 28),

                              // Key Details Section
                              _buildSectionTitle('Key Details'),
                              const SizedBox(height: 16),
                              _buildDetailGrid(
                                  examattendVm.questions.length.toString(),
                                  examattendVm.examData.value!.markPerQuestion,
                                  examattendVm.examData.value!.minusMark,
                                  examattendVm
                                      .timeconvert(examattendVm
                                          .examData.value!.totalTime)
                                      .toString()),
                              const SizedBox(height: 28),

                              // Instructions Section
                              _buildSectionTitle('Important Instructions'),
                              const SizedBox(height: 16),
                              _buildInstructionList(),
                              const SizedBox(height: 24),
                              // Terms Checkbox
                              _buildTermsCheckbox(),
                              const SizedBox(height: 32),

                              // Start Button
                              _buildStartButton(context),
                              // Bottom padding so content clears nav bar
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },
        ));
  }

  /// Shown when the API returns "Already Attempted" or any error that leaves
  /// examData null. Prevents the `!` null-check crash and gives the user a
  /// clear path back to the dashboard.
  Widget _buildAlreadyAttemptedScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.assignment_turned_in_rounded,
                  size: 72,
                  color: Colors.orange.shade600,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Exam Already Attempted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'You have already attempted this exam.\nYou cannot take it again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Get.offAllNamed(RouteName.navbar),
                  icon: const Icon(Icons.home_rounded, color: Colors.white),
                  label: const Text(
                    'Go to Dashboard',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.grey.shade400,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value ?? false;
                  });
                },
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I agree to all instructions and exam rules',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By checking this box, you confirm you have read and understood all exam guidelines',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String examDuration,
      String markperquestion, String totalQuestion) {
    // FIX: Safely parse values to avoid FormatException on empty strings
    final int total = int.tryParse(totalQuestion) ?? 0;
    final int mark = int.tryParse(markperquestion) ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Ready to begin your exam?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D3748),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please review all instructions carefully before starting',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: 16),
          // FIX: Wrap each item in Expanded so Row children share space evenly
          // and long values never push siblings out of bounds.
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Total Score',
                  '${total * mark}',
                ),
              ),
              Expanded(
                child: _buildSummaryItem('Duration', '$examDuration min'),
              ),
              Expanded(
                child: _buildSummaryItem('Questions', totalQuestion),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          overflow: TextOverflow.ellipsis, // FIX: prevent right overflow
          maxLines: 1,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          overflow: TextOverflow.ellipsis, // FIX: prevent right overflow
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2D3748),
      ),
    );
  }

  Widget _buildDetailGrid(String totalQus, String markperquestion,
      negativemark, String examDuration) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      // FIX: Was 3 (width:height = 3:1) → cells were only ~49px tall, too short
      // for icon (36px) + two text lines (~36px). Raised to 2.4 for proper fit.
      childAspectRatio: 2.4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildDetailTile(
          Icons.format_list_numbered_rounded,
          'Total Questions',
          totalQus,
          AppColors.primary,
        ),
        _buildDetailTile(
          Icons.star_rate_rounded,
          'Marks / Question',
          markperquestion,
          const Color(0xFF4FD1C5),
        ),
        _buildDetailTile(
          Icons.warning_rounded,
          'Negative Mark',
          '$negativemark',
          const Color(0xFFED8936),
        ),
        _buildDetailTile(
          Icons.timer_rounded,
          'Duration',
          '$examDuration min',
          AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildDetailTile(
      IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        // FIX: was missing crossAxisAlignment — default is center, which is fine
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon circle — fixed size, won't shrink
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 8),
          // FIX: Expanded prevents horizontal overflow.
          // Previously, Column had no constraint on width, so it could push
          // the Row wider than its parent → "overflowed by 5/17px on the right".
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // FIX: mainAxisSize.min lets the Column shrink to its content
              // instead of stretching to full tile height and overflowing.
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // FIX: clip long labels
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // FIX: clip long values
                  style: const TextStyle(
                    fontSize: 14, // FIX: reduced from 16 to fit tile height
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInstructionItem('All questions are mandatory to attempt.'),
          _buildInstructionItem(
              'There will be negative marking for wrong answers.'),
          _buildInstructionItem(
              'Use the navigation buttons to move between questions.'),
          _buildInstructionItem(
              'Timer will be shown at the top of the screen.'),
          _buildInstructionItem(
              'Don\'t close or switch the app during exam.'),
          _buildInstructionItem('Submit your answers before time runs out.'),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _termsAccepted
            ? () {
                Get.toNamed(RouteName.exampage);
              }
            : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor:
              _termsAccepted ? AppColors.primary : Colors.grey.shade400,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          'Start Exam Now',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}