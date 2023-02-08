import 'package:dio/dio.dart';

class DioClient {
  static const baseUrlDev = "";
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrlDev,
    connectTimeout: 30000,
    receiveTimeout: 20000,
    //headers:{"access-token": someKey}
  );
  static final DioClient _dioClient = DioClient._internal();
  // ignore: prefer_final_fields
  Dio _dio = Dio(baseOptions);

  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    _dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
  }
}
