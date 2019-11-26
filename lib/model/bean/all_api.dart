import 'dart:convert';
import 'dart:developer';

import 'package:all/model/bean/app_item.dart';


class AllApi {
  List<AppItem> appItemList;
  List<String> appList;

  AllApi({this.appItemList, this.appList});

  factory AllApi.fromJson(Map<String, dynamic> json) {
    return AllApi(
      appItemList: json['info_list'] != null ? (json['info_list'] as List).map((i) => AppItem.fromJson(i)).toList() : null,
      appList: json['list'] != null ? new List<String>.from(json['list']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appItemList != null) {
      data['info_list'] = this.appItemList.map((v) => v.toJson()).toList();
    }
    if (this.appList != null) {
      data['list'] = this.appList;
    }
    return data;
  }
}
