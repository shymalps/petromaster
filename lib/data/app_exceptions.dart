class AppExceptions implements Exception {
  final _message;
  final _prefix;


  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

//handle network exception
class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(message, "No Internet Connection");
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException([String? message])
      : super(message, "Request Time Out: ");
}

class ServerException extends AppExceptions {
  ServerException([String? message])
      : super(message, "Internal Server Error: ");
}

class InvalidurlException extends AppExceptions {
  InvalidurlException([String? message]) : super(message, "Invalid url: ");
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}
