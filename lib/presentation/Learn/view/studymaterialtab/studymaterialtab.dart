import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:oyster_lms/core/helpers/appbarhelper.dart';

import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../app/config/theme/text.dart';
import '../../../../core/helpers/appbarhelper.dart';
import '../../viewmodel/tabviewvm.dart';

class StudyMaterialTab extends StatelessWidget {
  const StudyMaterialTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tabbarVM = Get.find<Tabviewvm>();
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'Study Material'),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: Obx(
              () => tabbarVM.getpage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabbarVM = Get.find<Tabviewvm>();
    return Row(
      children: [
        _tabBarItem(tabbarVM.tabs[0], true),
        Container(width: 2, color: Colors.black),
        _tabBarItem(tabbarVM.tabs[1], false),
        Container(width: 2, color: Colors.black),
        _tabBarItem(tabbarVM.tabs[2], false),
        Container(width: 2, color: Colors.black),
        _tabBarItem(tabbarVM.tabs[3], false),
      ],
    );
  }

  Widget _tabBarItem(String title, bool state) {
    final tabbarVM = Get.find<Tabviewvm>();
    return Expanded(
      child: InkWell(
        onTap: () => tabbarVM.updateselection(title),
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(Di.width(0.025)),
            decoration: BoxDecoration(
              border: tabbarVM.selectedTab.value == title
                  ? const Border(
                      bottom: BorderSide(color: AppColors.primary, width: 3),
                    )
                  : const Border(),
              color: AppColors.white,
            ),
            child: Center(
              child: AppTextHelper.button(
                text: title,
                fcolor: AppColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
