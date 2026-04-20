import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/core/helpers/appbarhelper.dart';
import '../../../../app/Di/dimensions.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../../common/controller/profile_controller.dart';
// import '../../../settings/viewmodel/profilevm.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../viewmodel/coursedetailvm.dart';
import 'src/listitem.dart';

class PurchasedCourseList extends StatelessWidget {
  const PurchasedCourseList({super.key});

  @override
  Widget build(BuildContext context) {
    final coursedetailVm = Get.find<CoursedetailVM>();
    final profileVM = Get.find<Profilevm>();
    // final ongoingCourses = [
    //   {
    //     'title': 'Medical Officer of Health (MOH)',
    //     'progress': 0.65,
    //     'instructor': 'Sujith',
    //     'thumbnail':
    //         'https://images.unsplash.com/photo-1522542550221-31fd19575a2d?w=500&auto=format&fit=crop',
    //   },

    // ];
    return Scaffold(
      appBar: Appbarhelper.dashboardAppbar(
          profileVM.profileData?.name ?? '', profileVM.profileData?.email ?? ''),
      body: Padding(
        padding: EdgeInsets.only(
            top: Di.screenWidth * 0.02,
            left: Di.screenWidth * 0.02,
            right: Di.screenWidth * 0.02),
        child: Obx(() {
          if (coursedetailVm.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (coursedetailVm.hasNoCourses.value) {
            return const Center(child: Text('You have no purchased course right now.'));
          } else if (coursedetailVm.ongoingCourses.value != null) {
            return ListCard(
              ongoingCourses: coursedetailVm.ongoingCourses.value!,
            );
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        }),
      ),
    );
  }
}
