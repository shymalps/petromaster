

import '../../core/utils/debuprint.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Profilerepo {
  final _apiService = NetworkApiServices();
  Future<dynamic> profile() async {
    consolePrint(
        '======================>In Profilerepo (function profile) Started');
        
    consolePrint('url ${await AppEndpoints.getprofile()}');
    dynamic response = await _apiService.getApi(
      await AppEndpoints.getprofile(),
    );
    consolePrint(
        '======================>In Profilerepo (function profile) Completed');
    return response;
  }
}
