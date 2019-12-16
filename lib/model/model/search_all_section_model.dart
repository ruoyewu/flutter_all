import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class SearchAllSectionModel extends ChangeNotifier {
	List<Section> _list;

	List<Section> get list => _list;

	set list (List<Section> value) {
		_list = value;
		notifyListeners();
	}


}