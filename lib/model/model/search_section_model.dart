import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class SearchSectionModel extends ChangeNotifier {
	List<AppItem> _list = [];
	bool hasMore = true;

	List<AppItem> get list => _list;

	set list (List<AppItem> value) {
		_list.addAll(value);
		notifyListeners();
	}


}