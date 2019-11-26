
import 'dart:io';

import 'package:all/model/ui_data.dart';
import 'package:dio/dio.dart';

class Network {
  static Network _sInstance;

  Dio _dio;

  Network() {
    _dio = Dio(BaseOptions(
      baseUrl: UIData.URL_BASE,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      contentType: "application/x-www-form-urlencoded",
    ));
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

  Future<Response> post(String url, Map<String, dynamic> data) async {
    final response = await _dio.post(url, data: data);
    return response;
  }
}