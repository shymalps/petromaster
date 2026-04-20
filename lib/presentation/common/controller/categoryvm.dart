import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/courselist_model.dart';
import '../../../domain/repository/coursedetailrepo.dart';

class CategoryVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    consolePrint(
      '==================> Category Controller Initialized',
    );
    getCategorylist();
    getCourselist();
  }

  RxBool isLoading = false.obs;
  RxBool iscourseloading = false.obs;
  RxString selectedCategory = 'All'.obs;
  final api = Coursedetailrepo();
  RxList<String> categoryList = <String>['All'].obs;
  RxList<CourseListModel> courseList = <CourseListModel>[].obs;

  void categorySelection(String value) {
    selectedCategory.value = value;
  }

  Future<void> getCategorylist() async {
    isLoading.value = true;
    consolePrint('==================> Category Controller Initialized');
    try {
      final response = await api.getcoursecategory();
      if (!ApiResponseHelper.isSuccess(response)) {
        consolePrint('==================> Category Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final dataList = ApiResponseHelper.listData(response);
      categoryList.addAll(dataList.map((item) => item.toString()).toList());
    } catch (e) {
      consolePrint(
          '==================> Category Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Category Controller Completed');
    }
  }

  Future<void> getCourselist() async {
    iscourseloading.value = true;
    consolePrint('==================> Category Controller Initialized');
    try {
      final response = await api.getcourselist();
      if (!ApiResponseHelper.isSuccess(response)) {
        courseList.clear();
        consolePrint('==================> Category Controller API Error',
            ApiResponseHelper.message(response));
        return;
      }

      final dataList = ApiResponseHelper.listData(response);
      courseList.value =
          dataList.map((item) => CourseListModel.fromJson(item)).toList();
    } catch (e) {
      consolePrint(
          '==================> Category Controller Error', e.toString());
    } finally {
      iscourseloading.value = false;
      consolePrint('==================> Category Controller Completed');
    }
  }
}
