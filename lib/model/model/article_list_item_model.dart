import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class ArticleListItemModel extends ChangeNotifier {
	ArticleListItem _articleListItem;

	ArticleListItem get articleListItem => _articleListItem;

	set articleListItem (ArticleListItem value) {
		_articleListItem = value;
		notifyListeners();
	}


}