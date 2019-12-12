import 'dart:convert';

import 'package:all/model/bean/all_api.dart';
import 'package:all/model/bean/net_result.dart';
import 'package:all/model/bean/qingmang_result.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/url.dart';
import 'package:all/utils/network.dart';
import 'package:dio/dio.dart';

class RemoteData {
  static Network get _network => Network.sInstance;

  static Future<AllApi> api() async {
    final response = await _network.get(UIData.URL_API);
    return AllApi.fromJson(response.data);
  }

//  static Future<ArticleList> articleList(
//      String app, String category, String page) async {
//    final response = await _network.get(UIData.URL_ARTICLE_LIST,
//        query: {"app": app, "category": category, "page": page});
//    return ArticleList.fromJson(response.data);
//  }

//  static Future<ArticleDetail> articleDetail(
//      String app, String category, String id) async {
//    final response = await _network.get(UIData.URL_ARTICLE_DETAIL,
//        query: {'app': app, 'category': category, 'id': id});
//    return ArticleDetail.fromJson(response.data);
//  }

  static Future<NetResult> verifyCode(
      String phone, String nationCode, String type) async {
    final response = await _network.get(UIData.URL_VERIFY_CODE,
        query: {'phone': phone, 'nation_code': nationCode, 'type': type});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> login(String id, String password) async {
    final response = await _network
        .get(UIData.URL_LOGIN, query: {'id': id, 'password': password});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> logout() async {
    final response = await _network.get(UIData.URL_LOGOUT);
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> register(String id, String password, String phone,
      String code, String name) async {
    final response = await _network.post(UIData.URL_USER, {
      'id': id,
      'password': password,
      'phone': phone,
      'code': code,
      'name': name
    });
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> getUserInfo(String id) async {
    final response = await _network.get(UIData.URL_USER, query: {'id': id});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> articleInfo(String article) async {
    final response = await _network
        .get(UIData.URL_ARTICLE_INFO, query: {'article': article});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> praiseArticle(String article) async {
    final response =
        await _network.post(UIData.URL_ARTICLE_PRAISE, {'article': article});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> collectArticle(
      String article, String content) async {
    final response = await _network.post(
        UIData.URL_ARTICLE_COLLECT, {'article': article, 'content': content});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> articleCollection(String user, int next) async {
    final response = await _network
        .get(UIData.URL_ARTICLE_COLLECT, query: {'user': user, 'time': next});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> commentArticle(
      String article, int parent, String comment) async {
    final response = await _network.post(UIData.URL_ARTICLE_COMMENT,
        {'article': article, 'content': comment, 'parent': parent});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> deleteComment(int id) async {
    final response =
        await _network.delete(UIData.URL_ARTICLE_COMMENT, {'id': id});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> praiseComment(int id) async {
    final response =
        await _network.post(UIData.URL_PRAISE_COMMENT, {'comment': id});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> artileComment(String article, int time) async {
    final response = await _network.get(UIData.URL_ARTICLE_COMMENT,
        query: {'article': article, 'time': time});
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> uploadAvatar(String path) async {
    final response = await _network.post(UIData.URL_AVATAR,
        FormData.fromMap({'avatar': await MultipartFile.fromFile(path)}));
    return NetResult.fromJson(response.data);
  }
  
  static Future<Result> searchApp(String search) async {
    final response = await _network.get(Url.SEARCH, query: {
      'query': search,
      'appOnly': true
    });
    return Result.fromJson(json.decode(response.data));
  }

  static Future<Result> articleList(int start, int max, int providerId) async {
    final response = await _network.get(Url.ARTICLE, query: {
      'start': start,
      'max': max,
      'providerId': providerId
    });
    return Result.fromJson(json.decode(response.data));
  }

  static Future<Result> articleDetail(int id, String template) async {
    final response = await _network.get(Url.ARTICLE, query: {
      'docid': id,
      'template': template
    });
    return Result.fromJson(json.decode(response.data));
  }

  static Future<Result> request(String url) async {
    final response = await _network.get(url);
    return Result.fromJson(json.decode(response.data));
  }

  static Future<Result> appDetail(String pns) async {
    final response = await _network.get(Url.APP_DETAIL, query: {
      'pns': pns
    });
    return Result.fromJson(json.decode(response.data));
  }
}
