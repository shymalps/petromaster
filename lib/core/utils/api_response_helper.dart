class ApiResponseHelper {
  /// Returns true for any recognised "success" value from the server.
  ///
  /// Different API endpoints on this backend return different formats:
  ///   {"status": "success"}  ← exam_start (works)
  ///   {"status": 1}          ← next_question (was failing)
  ///   {"status": "1"}        ← alternative string form
  ///   {"status": true}       ← boolean form
  ///   {"status": "ok"}       ← plain ok form
  ///
  /// Previously only "success" (exact string) was accepted, causing
  /// "Failed to submit answer" even when the server actually accepted the data.
  static bool isSuccess(dynamic response) {
    if (response is! Map) return false;
    final status = response['status'];
    return status == 'success' ||
        status == 'ok' ||
        status == 'OK' ||
        status == 1 ||
        status == '1' ||
        status == true ||
        status == 200 ||
        status == '200';
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