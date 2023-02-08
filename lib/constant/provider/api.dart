import 'dart:convert';
import 'dart:io';
import 'package:biznew/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import '../../utils/pref_user_data.dart';
import '../../utils/utils.dart';
import 'custom_exception.dart';
import 'dio_client.dart';

class ApiClient {
  final Dio httpClient = DioClient().dio;

  ///set common header
  Map<String, String> _setHeaders(Map<String, String> headers) {
    // ignore: unnecessary_null_comparison
    if (PrefData().getAuthToken() != null) {
      headers["authorization"] = PrefData().getAuthToken();
    }
    return headers;
  }

  ///api get method
  /// url : api url
  /// headers : api header
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(headers: headers);
    try {
      var response = await httpClient.get(url, options: options);
      return _handleResponse(response);
    } on Exception catch (exception) {
      _handleError(exception);
    }
    return null;
  }

  ///api post method
  ///url : api url
  ///headers : api header
  ///body : api body
  ///contentType : contentType can be application/json or application/x-www-form-urlencoded
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    body,
    String contentType = Headers.formUrlEncodedContentType,
  }) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(
        followRedirects: false,
        validateStatus: (status) => true,
        headers: headers,
        contentType: contentType);
    var bodyData =
        contentType == Headers.jsonContentType ? json.encode(body) : body;
    try {
      var response = await httpClient.post(
        url,
        options: options,
        data: bodyData,
      );
      return _handleResponse(response);
    } on Exception catch (exception) {
      return _handleError(exception);
    }
  }

  ///api put method
  ///url : api url
  ///headers : api headers
  ///body : api body
  Future<dynamic> put(String url, {Map<String, String>? headers, body}) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(headers: headers);
    try {
      var response = await httpClient.put(url, options: options, data: body);
      return _handleResponse(response);
    } on Exception catch (exception) {
      _handleError(exception);
    }
    return null;
  }

  Future<dynamic> putDio(String url, {Map<String, String>? headers, body,}) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(
        followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
        headers: headers);
    try {
      var dio = Dio();
      var response = await dio.put(url, options: options, data: body);
      return _handleResponse(response);
    } on Exception catch (exception) {
      _handleError(exception);
    }
    return null;
  }

  ///api delete method
  ///url : api url
  ///headers : api headers
  ///body : api body
  Future<dynamic> delete(String url,
      {Map<String, String>? headers, body}) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(headers: headers);
    try {
      var response = await httpClient.delete(url, options: options, data: body);
      return _handleResponse(response);
    } on Exception catch (exception) {
      _handleError(exception);
    }
    return null;
  }

  Future<dynamic> postMedia(String url,
      {Map<String, String>? headers,
      body,
      Function(double)? uploadProgress}) async {
    bool hasNet = await Utils.isConnectedToInternet();
    if (!hasNet) {
      throw CustomException(CustomException.errorConnection,
          CustomException.errorNoInternetConnection);
    }
    Options options = Options(
      headers: headers,
    );

    try {
      var response = await httpClient.post(
        url,
        options: options,
        data: body,
        onSendProgress: (int received, int total) {
          if (total != -1) {
            uploadProgress!((received / total * 100));
          }
        },
      );
      return _handleResponse(response);
    } on Exception catch (exception) {
      return _handleError(exception);
    }
  }

  ///here we handle success response
  dynamic _handleResponse(Response? response) {
    final int? statusCode = response?.statusCode;
    final isSuccess = statusCode! >= 200 && statusCode <= 299;

    if (isSuccess) {
      return response?.data;
    } else {
      throw CustomException(statusCode, CustomException.errorCrashMsg);
    }
  }

  int counter = 0;

  ///here we handle error response
  dynamic _handleError(Exception? exception) {
    int errorCode = 0;
    String errorMsg = "";
    dynamic errorResponse;
    try {
      if (exception is DioError) {
        errorCode = exception.response?.statusCode ?? 0;
        errorResponse = exception.response?.data ?? exception.toString();

        if (exception.type == DioErrorType.connectTimeout) {
          errorMsg = CustomException.defaultConnectTimeoutMsg;
        } else if (exception.type == DioErrorType.response) {
          if (exception.response?.statusCode == 403) {
            counter++;
            if (counter == 2) {
              PrefData().clearData();
              g.Get.offAllNamed(AppRoutes.login);
            }
          }
        }
      } else if (exception is SocketException) {
        errorMsg = CustomException.defaultConnectTimeoutMsg;
        errorCode = CustomException.errorConnection;
        errorResponse = errorMsg;
      } else {
        errorMsg = CustomException.errorCrashMsg;
        errorCode = CustomException.errorDefault;
      }
    } catch (e) {
      errorMsg = CustomException.errorCrashMsg;
      errorCode = CustomException.errorDefault;
      errorResponse = errorMsg;
    }
    throw CustomException(errorCode, errorMsg, errorResponse);
  }
}
