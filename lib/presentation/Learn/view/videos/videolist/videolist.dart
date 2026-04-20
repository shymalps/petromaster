import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../app/Di/dimensions.dart';
import '../../../../shared/view/animatedlistview.dart';
import '../../../../shared/view/nodatafound.dart';
import '../../../viewmodel/videolistvm.dart';
import 'src/list_shimmer.dart';
import 'src/listitem.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    final videoVM = Get.find<VideolistVM>();
    return Obx(
      () => videoVM.videoList.isEmpty && videoVM.isLoading.value
          ? const VideoListItemShimmer()
          : videoVM.videoList.isEmpty
              ? const Emptypage()
              : Padding(
                  padding: EdgeInsets.only(
                      top: Di.screenWidth * 0.02,
                      left: Di.screenWidth * 0.02,
                      right: Di.screenWidth * 0.02),
                  child: AnimatedListView(
                    itemcount: videoVM.videoList.length,
                    itemBuilder: (context, index, animation) {
                      return FadeTransition(
                        opacity:
                            animation.drive(CurveTween(curve: Curves.easeIn)),
                        child: VideoListItem(
                          videoData: videoVM.videoList[index],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
