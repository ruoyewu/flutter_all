import 'package:all/model/bean/article_comment_list_item.dart';
import 'package:flutter/material.dart';

class ArticleCommentItemModel extends ChangeNotifier {
	ArticleCommentListItem _articleCommentListItem;

	ArticleCommentListItem get articleCommentListItem => _articleCommentListItem;

	set articleCommentListItem (ArticleCommentListItem value) {
		_articleCommentListItem = value;
		notifyListeners();
	}
}