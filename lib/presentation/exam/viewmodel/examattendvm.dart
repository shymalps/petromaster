import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/routes/route_name.dart';
import '../../../app/config/theme/colors.dart';
import '../../../core/utils/api_response_helper.dart';
import '../../../core/helpers/dialougehelper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/examdata_model.dart';
import '../../../domain/models/questionlist_model.dart';
import '../../../domain/repository/examrepo.dart';

class Examattendvm extends GetxController {
  final String examid;
  Examattendvm({required this.examid});

  @override
  void onInit() {
    super.onInit();
    getQuestions(examid);
    consolePrint('==================> Exam Attend Controller Initialized');
  }

  final api = Examrepo();
  RxInt currentindex = 0.obs;
  RxString selectedoption = ''.obs;
  RxBool isloading = false.obs;
  RxBool isSubmitting = false.obs;
  RxList<Question> questions = <Question>[].obs;
  final examData = Rxn<ExamDataModel>();

  int timeconvert(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return (hours * 60) + minutes;
  }

  Future<void> nextquestion(String qusId, String ans) async {
    consolePrint(
        'Current Index ${currentindex.value}, ${questions.length - 1}');
    if (isSubmitting.value) return;

    if (currentindex.value < questions.length - 1) {
      // ── Intermediate question ──────────────────────────────────────────────
      isSubmitting.value = true;
      try {
        final submitted = await submitanswer(qusId, ans);
        if (!submitted) {
          consolePrint(
              '==================> submitanswer failed for Q$qusId, navigating anyway');
        }
        currentindex.value++;
        selectedoption.value = '';
      } finally {
        isSubmitting.value = false;
      }
    } else if (currentindex.value == questions.length - 1) {
      // ── Last question ──────────────────────────────────────────────────────
      isSubmitting.value = true;
      try {
        await submitanswer(qusId, ans);

        final examCompleted = await _completeExam();
        if (!examCompleted) {
          Dialougehelper.error(
            Get.context,
            'Submission Failed',
            'Exam could not be finalized. Please check your connection and tap Submit again.',
          );
          return;
        }

        // Show "Submitted Successfully" dialog with View Result option
        _showSuccessDialog();
      } finally {
        isSubmitting.value = false;
      }
    }
  }

  /// Shows the exam-submitted success dialog.
  /// User can go to result screen or back to dashboard.
  void _showSuccessDialog() {
    Get.dialog(
      PopScope(
        canPop: false, // back button should not dismiss
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Success icon ─────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green.shade600,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Title ────────────────────────────────────────────────────
                const Text(
                  'Submitted Successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your exam has been submitted.\nTap "View Result" to see your score.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),

                // ── View Result button ───────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back(); // close dialog
                      // Navigate to result screen, clear all exam routes
                      Get.offAllNamed(
                        RouteName.examresult,
                        arguments: examid,
                      );
                    },
                    icon: const Icon(Icons.bar_chart_rounded,
                        color: Colors.white),
                    label: const Text(
                      'View Result',
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
                const SizedBox(height: 12),

                // ── Back to Dashboard ────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.back(); // close dialog
                      Get.offAllNamed(RouteName.navbar);
                    },
                    icon: Icon(Icons.dashboard_outlined,
                        color: AppColors.primary),
                    label: Text(
                      'Back to Dashboard',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Returns true if we got any HTTP-200 response (any body).
  /// Returns false only on exception (network error / 4xx / 5xx).
  Future<bool> submitanswer(String qusId, String ans) async {
    consolePrint(
        '==================>In Exam Attend VM (function submitanswer) Started');
    try {
      final response = await api.submitanswer(qusId, ans, examid);
      if (ApiResponseHelper.isSuccess(response)) {
        consolePrint('==================> submitanswer: SUCCESS');
        return true;
      }
      // Non-standard response — server received it, treat as success
      consolePrint(
          '==================> submitanswer: non-standard response (treating as success)',
          response.toString());
      return true;
    } catch (e) {
      consolePrint(
          '==================> submitanswer: FAILED (exception)', e.toString());
      return false;
    } finally {
      consolePrint(
          '==================> Exam Attend VM (function submitanswer) Completed');
    }
  }

  Future<bool> _completeExam() async {
    consolePrint(
        '==================>In Exam Attend VM (function _completeExam) Started');
    try {
      await api.submitexam(examid);
      consolePrint('==================> _completeExam: SUCCESS');
      return true;
    } catch (e) {
      consolePrint('==================> _completeExam: FAILED', e.toString());
      return false;
    }
  }

  void previousquestion() {
    if (currentindex.value > 0) {
      currentindex.value--;
    }
  }

  void handleTimerFinish(bool finished) {
    Get.offNamed(RouteName.timeout);
  }

  void updateselection(String option) {
    if (selectedoption.value == option) {
      selectedoption.value = '';
    } else {
      selectedoption.value = option;
    }
    consolePrint('Selected option: ${selectedoption.value}');
  }

  Future<void> getQuestions(String examid) async {
    consolePrint(
        '==================>In Exam Attend VM (function getQuestions) Initialized');
    try {
      isloading.value = true;
      final response = await api.questions(examid);
      if (!ApiResponseHelper.isSuccess(response)) {
        questions.clear();
        examData.value = null;
        consolePrint('==================> getQuestions API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final data = ApiResponseHelper.listData(response);
      questions.value = data.map((e) => Question.fromJson(e)).toList();
      if (response is Map && response['exam'] is Map<String, dynamic>) {
        examData.value = ExamDataModel.fromJson(response['exam']);
      } else {
        examData.value = null;
      }
    } catch (e) {
      consolePrint('==================> getQuestions Error', e.toString());
    } finally {
      isloading.value = false;
      consolePrint(
          '==================> Exam Attend VM (function getQuestions) Completed');
    }
  }

  @override
  void onClose() {
    super.onClose();
    consolePrint('==================> Exam Attend Controller Closed');
  }
}