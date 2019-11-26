import 'dart:convert';
import 'dart:developer';

import 'package:all/model/bean/all_api.dart';
import 'package:all/model/bean/article_detail.dart';
import 'package:all/model/bean/article_list.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/utils/network.dart';

class RemoteData {
  static Network get _network => Network.sInstance;

  static Future<AllApi> api() async {
    final response = await _network.get(UIData.URL_API);
    return AllApi.fromJson(json.decode(response.data));
  }

  static Future<ArticleList> articleList(String app, String category, String page) async {
    Map query = {
      "app": app,
      "category": category,
      "page": page
    };
    final response = await _network.get(UIData.URL_ARTICLE_LIST + "?app=$app&category=$category&page=$page");
    return ArticleList.fromJson(json.decode(response.data));
  }
  
  static Future<ArticleDetail> articleDetail(String app, String category, String id) async {
    final response = await _network.get(UIData.URL_ARTICLE_DETAIL + "?app=$app&category=$category&id=$id");
    return ArticleDetail.fromJson(json.decode(response.data));
  }
}