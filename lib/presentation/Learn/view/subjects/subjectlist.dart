import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:oyster_lms/core/helpers/appbarhelper.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/subjectvm.dart';
import 'src/listitem.dart';
import 'src/subjectshimmer.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectVM = Get.find<SubjectVM>();
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'Subjects'.tr),
      body: Obx(
        () => subjectVM.subjectList.isEmpty && subjectVM.isLoading.value
            ? const SubjectShimmerLoader()
            : subjectVM.subjectList.isEmpty
                ? const Emptypage()
                : Padding(
                    padding: EdgeInsets.only(
                        top: Di.screenWidth * 0.02,
                        left: Di.screenWidth * 0.02,
                        right: Di.screenWidth * 0.02),
                    child: AnimatedListView(
                      itemcount: subjectVM.subjectList.length,
                      itemBuilder: (context, index, animation) {
                        return FadeTransition(
                          opacity:
                              animation.drive(CurveTween(curve: Curves.easeIn)),
                          child: SubjectCard(
                              subject: subjectVM.subjectList[index]),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
