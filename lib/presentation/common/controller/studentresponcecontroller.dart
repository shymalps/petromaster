import 'package:petromaster/core/utils/debuprint.dart';
import 'package:petromaster/core/utils/api_response_helper.dart';
import 'package:petromaster/domain/repository/studentresponserepo.dart';
import 'package:petromaster/presentation/Learn/viewmodel/getstudentresponse.dart';
import 'package:get/get.dart';

class GetStudentResponseController extends GetxController {
  final api = studentResponcerepo();

  RxBool isloading = false.obs;

  StudentData? studentData;

  @override
  void onInit() {
    super.onInit();
    consolePrint('==================> Student Response Controller Initialized');
  }

  /// Fetch single student data by ID
Future<void> getStudentById(String id) async {
  isloading.value = true;

  try {
    final response = await api.getStudentResponse();

    if (!ApiResponseHelper.isSuccess(response)) {
      studentData = null;
      return;
    }

    final data = response["data"];

    // API returns MAP not LIST
    if (data is Map<String, dynamic>) {
      final studentJson = data["0"]; // 👈 actual student object

      if (studentJson != null) {
        studentData = StudentData.fromJson(studentJson);
        consolePrint("Selected Student: ${studentData?.name}");
      } else {
        studentData = null;
      }
    }
  } catch (e) {
    consolePrint("Error fetching student", e.toString());
  } finally {
    isloading.value = false;
  }
}
}
