import '../../AuthPref.dart';
import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Studymaterialrepo {
  final _apiService = NetworkApiServices();
  Future<dynamic> getstudymaterials(String lessonId, topicId, type) async {
    consolePrint(
        '======================>In Studymaterialrepo (function getstudymaterials) Started');
    final data = {
      'type': type,
      'name': '',
      'topic_id': topicId,
      'lesson_id': lessonId
    };
    try {
      dynamic response =
          await _apiService.postApi(data, AppEndpoints.getstudymaterials);
      consolePrint(
          '======================>In Studymaterialrepo(function getVideos) Completed');
      return response;
    } catch (e) {}
  }

  Future<dynamic> getVideos(String topicId) async {
    consolePrint(
        '======================>In Studymaterialrepo (function getVideos) Started');
    consolePrint('url ${AppEndpoints.videos + topicId}');
    dynamic response = await _apiService.getApi(AppEndpoints.videos + topicId);
    consolePrint(
        '======================>In Studymaterialrepo(function getVideos) Completed');
    return response;
  }

  Future<dynamic> getnotes(String topicId) async {
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Started');
    consolePrint('url ${AppEndpoints.getNotes(topicId)}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getNotes(topicId));
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Completed');
    return response;
  }

  Future<dynamic> getaudio(String topicId) async {
    consolePrint(
        '======================>In Studymaterialrepo (function getaudio) Started');
    consolePrint('url ${AppEndpoints.getAudio(topicId)}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getAudio(topicId));
    consolePrint(
        '======================>In Studymaterialrepo (function getaudio) Completed');
    return response;
  }

  Future<dynamic> gettypednotes(String topicId) async {
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Started');
    consolePrint('url ${AppEndpoints.getTypednotes(topicId)}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getTypednotes(topicId));
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Completed');
    return response;
  }

  Future<dynamic> videoseen(String videoId) async {
    var data = {
      'video_id': videoId,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Started');
    consolePrint('url ${AppEndpoints.videoseen}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.videoseen);
    consolePrint(
        '======================>In Studymaterialrepo (function getnotes) Completed');

    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> noteseen(String noteId) async {
    var data = {
      'notes_id': noteId,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint(
        '======================>In Studymaterialrepo (function noteseenApi) Started');
    consolePrint('url ${AppEndpoints.noteseen}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.noteseen);
    consolePrint(
        '======================>In Studymaterialrepo (function noteseenApi) Completed');
    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> audioseen(String noteId) async {
    var data = {
      'audio_id': noteId,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint(data.toString());
    consolePrint(
        '======================>In Studymaterialrepo (function noteseenApi) Started');
    consolePrint('url ${AppEndpoints.audioseen}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.audioseen);
    consolePrint(
        '======================>In Studymaterialrepo (function noteseenApi) Completed');
    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
