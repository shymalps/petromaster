import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/routes/route_name.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/topicvm.dart';
import 'src/listitem.dart';
import 'src/shimmerloader.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key});

  @override
  Widget build(BuildContext context) {
    final topicVM = Get.find<TopicVM>();
    return Scaffold(
        appBar: Appbarhelper.pageAppbar(title: 'Topics'.tr),
        body: Obx(
          () => topicVM.topicList.isEmpty && topicVM.isLoading.value
              ? const TopicShimmerLoader()
              : topicVM.topicList.isEmpty
                  ? const Emptypage()
                  : Padding(
                      padding: EdgeInsets.only(
                          top: Di.screenWidth * 0.02,
                          left: Di.screenWidth * 0.02,
                          right: Di.screenWidth * 0.02),
                      child: AnimatedListView(
                        itemcount: topicVM.topicList.length,
                        itemBuilder: (context, index, animation) {
                          return FadeTransition(
                            opacity: animation
                                .drive(CurveTween(curve: Curves.easeIn)),
                            child: ModernTopicCard(
                              onTap: () {
                                Get.toNamed(RouteName.studymaterialtab,
                                    arguments:
                                        topicVM.topicList[index].topicId);
                              },
                              topicName: topicVM.topicList[index].chapter,
                              videoCount: topicVM.topicList[index].videoCount,
                              notesCount: topicVM.topicList[index].notesCount,
                              audioCount: topicVM.topicList[index].audioCount,
                              isLocked: false,
                              totalviewedcontent: topicVM
                                      .topicList[index].viewedVideoCount +
                                  topicVM.topicList[index].viewedAudioCount +
                                  topicVM.topicList[index].viewedNotesCount,
                            ),
                          );
                        },
                      ),
                    ),
        ));
  }
}
