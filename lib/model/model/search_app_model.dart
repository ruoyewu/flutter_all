import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class SearchAppModel extends ChangeNotifier {
	List<AppItem> _searchAppList;
	bool _hasMore = false;

	List<AppItem> get searchAppList => _searchAppList;


	bool get hasMore => _hasMore;

	set searchAppList (List<AppItem> value) {
		_searchAppList = value;
		notifyListeners();
	}
}