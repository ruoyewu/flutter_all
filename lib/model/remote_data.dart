import 'package:all/model/bean/all_api.dart';
import 'package:all/model/bean/article_detail.dart';
import 'package:all/model/bean/article_list.dart';
import 'package:all/model/bean/net_result.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/utils/network.dart';

class RemoteData {
  static Network get _network => Network.sInstance;

  static Future<AllApi> api() async {
    final response = await _network.get(UIData.URL_API);
    return AllApi.fromJson(response.data);
  }

  static Future<ArticleList> articleList(String app, String category, String page) async {
    final response = await _network.get(UIData.URL_ARTICLE_LIST, query: {
      "app": app,
      "category": category,
      "page": page
    });
    return ArticleList.fromJson(response.data);
  }
  
  static Future<ArticleDetail> articleDetail(String app, String category, String id) async {
    final response = await _network.get(UIData.URL_ARTICLE_DETAIL, query: {
      'app': app,
      'category': category,
      'id': id
    });
    return ArticleDetail.fromJson(response.data);
  }

  static Future<NetResult> verifyCode(String phone, String nationCode, String type) async {
    final response = await _network.get(UIData.URL_VERIFY_CODE, query: {
      'phone': phone,
      'nation_code': nationCode,
      'type': type
    });
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> login(String id, String password) async {
    final response = await _network.get(UIData.URL_LOGIN, query: {
      'id': id,
      'password': password
    });
    return NetResult.fromJson(response.data);
  }

  static Future<NetResult> register(String id, String password, String phone, String code, String name) async {
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
    final response = await _network.get(UIData.URL_USER, query: {
      'id': id
    });
    return NetResult.fromJson(response.data);
  }
}