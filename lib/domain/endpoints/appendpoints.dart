
import '../../AuthPref.dart';
import '../../core/constant/constants.dart';

class AppEndpoints {
  static Future<String> getSubjects() async {
    String? classId = await AuthPreferences.getclassId();
    String? stuId = await AuthPreferences.getstuId();
    return '${Constants.appBaseUrl}get_subject/$classId/$stuId';
  }

  static Future<String> getStudentResponse() async {
    String? userId = await AuthPreferences.getUserId();
    return '${Constants.appBaseUrl}getUserDatas/$userId';
  }

  static Future<String> getTopics(String subId) async {
    String? stuId = await AuthPreferences.getstuId();
    return '${Constants.appBaseUrl}get_topic/$subId/$stuId';
  }

  static Future<String> getNotes(String topicId) async {
    return '${Constants.appBaseUrl}get_table_muti_row?tname=notes&where=topic_id&value=$topicId';
  }

  static Future<String> getAudio(String topicId) async {
    return '${Constants.appBaseUrl}get_table_muti_row?tname=audio&where=topic_id&value=$topicId';
  }

  static Future<String> getTypednotes(String topicId) async {
    return '${Constants.appBaseUrl}get_table_muti_row?tname=typable_notes&where=topic_id&value=$topicId';
  }

  static Future<String> getlessons(String topicId) async {
    return '${Constants.appBaseUrl}get_table_muti_row?tname=lession&where=topicid&value=$topicId';
  }


    static Future<String> getCoursedetails() async {
    String? classId = await AuthPreferences.getclassId();
    return '${Constants.appBaseUrl}courseDetails/$classId';
  }



  static Future<String> getCoursedetails2(String courseId) async {
    return '${Constants.appBaseUrl}course_details/$courseId';
  }
  /////////////////////////////////////
  //  static Future<String>getStudentResponse() async {
  //   String? classId = await AuthPreferences.getclassId();
  //   return '${Constants.appBaseUrl}getUserDatas/$classId';

  // }

  static Future<String> getprofile() async {
    String? userID = await AuthPreferences.getUserId();
    return '${Constants.appBaseUrl}ProfileData/$userID';
  }

  static const String login = '${Constants.appBaseUrl}user_login';
  static const String examlist = '${Constants.appBaseUrl}view_exam_list';
  static const String questions = '${Constants.appBaseUrl}exam_start';
  static const String videos = '${Constants.appBaseUrl}get_videos_by_topic_id/';
  static const String nextquestion = '${Constants.appBaseUrl}next_question';
  static const String completeexam = '${Constants.appBaseUrl}exam_complete';
  static const String examresult = '${Constants.appBaseUrl}exam_result';
  static const String videoseen = '${Constants.appBaseUrl}set_video_seen';
  static const String noteseen = '${Constants.appBaseUrl}set_notes_seen';
  static const String audioseen = '${Constants.appBaseUrl}set_audio_seen';
  static const String zoommeetlist = '${Constants.appBaseUrl}upcomingMeetings/';
  static const String category = '${Constants.appBaseUrl}course_category';
  static const String courselist = '${Constants.appBaseUrl}course_list';
  static const String updatedeviceId = '${Constants.appBaseUrl}store_device_id';
  static const String getloginmode =
      '${Constants.appBaseUrl}get_table_sin_row?tname=admin_profile&where=profile_id&value=1';
  static const String getstudymaterials =
      '${Constants.appBaseUrl}get_studydata_topicid';
}
