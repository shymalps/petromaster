import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/core/helpers/appbarhelper.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/examresultvm.dart';
import 'src/listitem.dart';

class Examsolution extends StatelessWidget {
  const Examsolution({super.key});

  @override
  Widget build(BuildContext context) {
    final examResultvm = Get.find<Examresultvm>();
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'Exam Solution'),
      body: Obx(
        () => examResultvm.resultData.isEmpty && examResultvm.isloading.value
            ? const CircularProgressIndicator()
            : examResultvm.resultData.isEmpty
                ? const Emptypage()
                : Padding(
                    padding: EdgeInsets.only(
                        top: Di.screenWidth * 0.02,
                        left: Di.screenWidth * 0.02,
                        right: Di.screenWidth * 0.02),
                    child: AnimatedListView(
                      itemcount: examResultvm.resultData.length,
                      itemBuilder: (context, index, animation) {
                        return FadeTransition(
                          opacity:
                              animation.drive(CurveTween(curve: Curves.easeIn)),
                          child: Resultitem(
                            resultModel: examResultvm.resultData[index],
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
