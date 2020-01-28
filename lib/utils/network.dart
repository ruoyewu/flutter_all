import 'package:all/model/ui_data.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class Network {
  static Network _sInstance;

  Dio _dio;

  Network() {
    _dio = Dio(BaseOptions(
        baseUrl: UIData.URL_BASE,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        sendTimeout: 10000,
        contentType: "application/x-www-form-urlencoded",
        responseType: ResponseType.json));
    _dio.interceptors.add(CookieManager(CookieJar()));
  }

  static Network get sInstance {
    if (_sInstance == null) {
      _sInstance = new Network();
    }
    return _sInstance;
  }

  Future<Response> get(String url, {Map<String, dynamic> query}) async {
    final response = await _dio.get(url, queryParameters: query);
    return response;
  }

  Future<Response> post(String url, data) async {
    final response = await _dio.post(url, data: data);
    return response;
  }

  Future<Response> put(String url, data) async {
    final response = await _dio.put(url, data: data);
    return response;
  }

  Future<Response> delete(String url, data) async {
    final response = await _dio.delete(url, data: data);
    return response;
  }
}