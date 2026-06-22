import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/config/routes/route_name.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/Di/dimensions.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/examresultvm.dart';
import 'src/listitem.dart';

class Examsolution extends StatelessWidget {
  const Examsolution({super.key});

  void _goToDashboard() => Get.offAllNamed(RouteName.navbar);

  @override
  Widget build(BuildContext context) {
    final examResultvm = Get.find<Examresultvm>();

    // FIX: PopScope prevents the default back-pop (which would navigate back
    // to the exam page). Instead, back always goes to the dashboard.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _goToDashboard();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: const Text(
            'Exam Result',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          // FIX: Custom leading icon — tapping it goes to dashboard,
          // not back to the exam page.
          leading: IconButton(
            icon: const Icon((Icons.arrow_back_ios_new), color: Colors.white),
            tooltip: 'Dashboard',
            onPressed: _goToDashboard,
          ),
          elevation: 0,
        ),
        body: Obx(() {
          if (examResultvm.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (examResultvm.resultData.isEmpty) {
            return const Emptypage();
          }

          // ── Calculate score ─────────────────────────────────────────────
          final total = examResultvm.resultData.length;
          final correct = examResultvm.resultData
              .where((r) =>
                  r.yourAns.trim().toUpperCase() ==
                  r.currectAnwser.trim().toUpperCase())
              .length;
          final wrong = examResultvm.resultData
              .where((r) =>
                  r.yourAns.trim().isNotEmpty &&
                  r.yourAns.trim().toUpperCase() !=
                      r.currectAnwser.trim().toUpperCase())
              .length;
          final skipped = examResultvm.resultData
              .where((r) => r.yourAns.trim().isEmpty)
              .length;
          final percentage =
              total > 0 ? ((correct / total) * 100).round() : 0;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Score card ────────────────────────────────────────────
                _ScoreSummaryCard(
                  total: total,
                  correct: correct,
                  wrong: wrong,
                  skipped: skipped,
                  percentage: percentage,
                ),

                // ── Solutions header ──────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Di.screenWidth * 0.04, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.list_alt_rounded,
                          size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      Text(
                        'Detailed Solutions',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Solutions list ────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(
                    left: Di.screenWidth * 0.02,
                    right: Di.screenWidth * 0.02,
                    bottom: Di.screenWidth * 0.06,
                  ),
                  child: AnimatedListView(
                    itemcount: examResultvm.resultData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      return FadeTransition(
                        opacity: animation
                            .drive(CurveTween(curve: Curves.easeIn)),
                        child: Resultitem(
                          resultModel: examResultvm.resultData[index],
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ScoreSummaryCard extends StatelessWidget {
  final int total;
  final int correct;
  final int wrong;
  final int skipped;
  final int percentage;

  const _ScoreSummaryCard({
    required this.total,
    required this.correct,
    required this.wrong,
    required this.skipped,
    required this.percentage,
  });

  Color get _scoreColor {
    if (percentage >= 80) return Colors.green.shade600;
    if (percentage >= 50) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  List<Color> get _scoreGradient {
    if (percentage >= 80) {
      return [Colors.green.shade400, Colors.green.shade700];
    }
    if (percentage >= 50) {
      return [Colors.orange.shade400, Colors.orange.shade700];
    }
    return [Colors.red.shade400, Colors.red.shade700];
  }

  String get _scoreLabel {
    if (percentage >= 80) return 'Excellent! 🎉';
    if (percentage >= 50) return 'Good Effort! 👍';
    return 'Keep Practising! 💪';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _scoreGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: _scoreColor.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _scoreLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: total > 0 ? correct / total : 0,
                  strokeWidth: 10,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  color: Colors.white,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$correct / $total',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statChip(Icons.check_circle_outline_rounded, 'Correct',
                  '$correct', Colors.white),
              _divider(),
              _statChip(
                  Icons.cancel_outlined, 'Wrong', '$wrong', Colors.white),
              _divider(),
              _statChip(Icons.remove_circle_outline_rounded, 'Skipped',
                  '$skipped', Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(IconData icon, String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color.withOpacity(0.9), size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: color.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _divider() => Container(
        height: 40,
        width: 1,
        color: Colors.white.withOpacity(0.3),
      );
}