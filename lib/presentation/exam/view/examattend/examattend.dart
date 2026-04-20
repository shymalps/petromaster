import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/routes/route_name.dart';
import '../../../../app/config/theme/text.dart';
import '../../viewmodel/examattendvm.dart';
import 'src/examshimmer.dart';
import 'src/footerbutton.dart';
import 'src/options.dart';
import 'src/progressindicater.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      // App went to background
      print('App went to background');
      Get.offNamed(RouteName.examviolation);
      // Perform your background tasks here
    } else if (state == AppLifecycleState.resumed) {
      // App came back to foreground
      print('App returned to foreground');
    }
  }

  @override
  Widget build(BuildContext context) {
    final examattendVM = Get.find<Examattendvm>();
    return Obx(
      () => examattendVM.isloading.value
          ? const ExamScreenShimmer()
          : PopScope(
              canPop: false,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Di.screenWidth * 0.04),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        ProgressIndicater(
                          currentQuestion: examattendVM.currentindex.value + 1,
                          totalQuestions: examattendVM.questions.length,
                          onTimerFinish: examattendVM.handleTimerFinish,
                          minutes: examattendVM.timeconvert(
                              examattendVM.examData.value!.totalTime),
                        ),
                        const SizedBox(height: 32),
                        QuestionCard(
                          question: examattendVM
                              .questions[examattendVM.currentindex.value]
                              .questionText,
                        ),
                        const SizedBox(height: 24),
                        OptionsView(
                          options: [
                            examattendVM
                                .questions[examattendVM.currentindex.value]
                                .optionA,
                            examattendVM
                                .questions[examattendVM.currentindex.value]
                                .optionB,
                            examattendVM
                                .questions[examattendVM.currentindex.value]
                                .optionC,
                            examattendVM
                                .questions[examattendVM.currentindex.value]
                                .optionD,
                            examattendVM
                                .questions[examattendVM.currentindex.value]
                                .optionE
                          ],
                        ),
                        FooterButtons(
                          selectedOption: examattendVM.selectedoption.value,
                          onNext: () => examattendVM.nextquestion(
                              examattendVM
                                  .questions[examattendVM.currentindex.value].id
                                  .toString(),
                              examattendVM.selectedoption.value),
                          onPrevious: examattendVM.previousquestion,
                          islast: examattendVM.currentindex.value + 1 ==
                              examattendVM.questions.length,
                          isfirst: examattendVM.currentindex.value == 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String question;
  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child:
            AppTextHelper.subHead(text: question, fontWeight: FontWeight.w600));
  }
}
