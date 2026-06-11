import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class LoginRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    consolePrint(
        '======================>In login Repo (function loginApi) Started');
    consolePrint('url ${AppEndpoints.login}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.login);
    consolePrint(
        '======================>In login Repo (function loginApi) Completed');
    return response;
  }

  Future<dynamic> storedeviceId(String deviceID, userId) async {
    var data = {
      'user_id': userId,
      'device_id': deviceID,
    };
    consolePrint(data.toString());
    print("deviceid is $deviceID and userId is $userId");
    consolePrint(
        '======================>In login Repo (function storedeviceId) Started');
    consolePrint('url ${AppEndpoints.updatedeviceId}');
    
    dynamic response =
        await _apiService.postApi(data, AppEndpoints.updatedeviceId);
    
    consolePrint(
        '======================>In login Repo (function storedeviceId) Completed');
    return response;
  }

  Future<dynamic> getloginmode() async {
    consolePrint(
        '======================>In login Repo (function getloginmode) Started');
    consolePrint('url ${AppEndpoints.getloginmode}');
    dynamic response = await _apiService.getApi(AppEndpoints.getloginmode);
    consolePrint(
        '======================>In login Repo (function getloginmode) Completed');
    return response;
  }
}
