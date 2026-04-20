class ApiResponseHelper {
  static bool isSuccess(dynamic response) {
    return response is Map && response['status'] == 'success';
  }

  static String message(dynamic response) {
    if (response is Map && response['message'] != null) {
      return response['message'].toString();
    }
    return 'Unexpected response from server';
  }

  static List<dynamic> listData(dynamic response) {
    if (response is! Map) {
      return const [];
    }

    final data = response['data'];
    if (data is List) {
      return data;
    }

    return const [];
  }

  static Map<String, dynamic>? mapData(dynamic response) {
    if (response is! Map) {
      return null;
    }

    final data = response['data'];
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return null;
  }
}
