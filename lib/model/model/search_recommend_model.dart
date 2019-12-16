import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class SearchRecommendModel extends ChangeNotifier {
	List<ResultRecommend> _list;

	List<ResultRecommend> get list => _list;

	set list (List<ResultRecommend> value) {
		_list = value;
		notifyListeners();
	}


}