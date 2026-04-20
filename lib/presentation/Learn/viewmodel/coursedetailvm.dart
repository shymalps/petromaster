import 'package:petromaster/domain/models/course_details_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/api_response_helper.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/coursedetails_model.dart';
import '../../../domain/repository/coursedetailrepo.dart';

class CoursedetailVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    consolePrint(
      '==================>purchased Course Detail Controller Initialized',
    );
    getCourse();

    consolePrint(
      '==================> purchased Course Detail Controller getCourse called',
    );  
  }

  final api = Coursedetailrepo();
  RxBool isloading = false.obs;
  Rx<Course?> ongoingCourses = Rx<Course?>(null);
  RxBool hasNoCourses = false.obs;
  Course1? ongoingCourses2;

  Future<void> getCourse() async {
    isloading.value = true;
    hasNoCourses.value = false;
    consolePrint(
      '==================> purchased Course Detail Controller Initialized',
    );
    try {
      final response = await api.getcoursedetails();
      if (!ApiResponseHelper.isSuccess(response)) {
        consolePrint(
          '==================> purchased Course Detail Controller API Error',
          ApiResponseHelper.message(response),
        );
        hasNoCourses.value = true;
        ongoingCourses.value = null;
        return;
      }

      final data = ApiResponseHelper.mapData(response);
      // Handle empty string, empty list, or null
      if (data == null || data.isEmpty) {
        hasNoCourses.value = true;
        ongoingCourses.value = null;
        return;
      }
      ongoingCourses.value = Course.fromJson(data);
    } catch (e) {
      consolePrint(
        '==================> purchased Course Detail Controller Error',
        e.toString(),
      );
      hasNoCourses.value = true;
      ongoingCourses.value = null;
    } finally {
      isloading.value = false;
      consolePrint(
        '==================> purchased Course Detail Controller Completed',
      );
    }
  }



Future<void> getCourse2(String courseId) async {
  consolePrint(
    '==================> Course Detail Controller getCourse2 Started for courseId: $courseId',
  );
  isloading.value = true;
  try {
    final response = await api.getcoursedetails2(courseId);

    if (!ApiResponseHelper.isSuccess(response)) {
      consolePrint(
        '==================> API Error: ${ApiResponseHelper.message(response)}',
      );
      return;
    }

    final data = ApiResponseHelper.mapData(response);
    if (data == null || data.isEmpty) {
      consolePrint('==================> Invalid data format: $data');
      return;
    }

    ongoingCourses2 = Course1.fromJson(data);

  } catch (e) {
    consolePrint('==================> Course Detail Controller Error', e.toString());
  } finally {
    isloading.value = false;
  }
}
}
