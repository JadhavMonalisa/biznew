class CustomException implements Exception {
  static const String errorNoInternetConnection =
      "Unable to connect to Bizalys. Please check your internet connection and try again.";
  static const String errorCrashMsg =
      "Something went wrong, Please try again later.";

  static const String defaultConnectTimeoutMsg =
      "We encountered an unexpected error.";

  static const String invalidEmailPassword = "Invalid username or password";
  static const String invalidEmail = "Enter email id";
  static const String invalidPassword = "Enter password";

  static const errorConnection = 001;
  static const errorDefault = 002;

  String? exceptionMessage;
  final int _code;
  final dynamic _response;

  CustomException([this._code = 0, this.exceptionMessage, this._response]);

  int getCode() => _code;

  String? getMsg() => exceptionMessage;

  dynamic getResponse() => _response;

  @override
  String toString() {
    return "$exceptionMessage";
  }
}
