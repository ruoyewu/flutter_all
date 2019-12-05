import 'dart:convert' show jsonDecode, jsonEncode;

import 'article_list_item.dart';

class ArticleCollectionListItem {
	String article;
	ArticleListItem content;
	int id;
	int time;
	String user;

	ArticleCollectionListItem({this.article, this.content, this.id, this.time, this.user});

	factory ArticleCollectionListItem.fromJson(Map<String, dynamic> json) {
		return ArticleCollectionListItem(
			article: json['article'],
			content: ArticleListItem.fromJson(jsonDecode(json['content'])),
			id: json['id'],
			time: json['time'],
			user: json['user'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['article'] = this.article;
		data['content'] = jsonEncode(this.content);
		data['id'] = this.id;
		data['time'] = this.time;
		data['user'] = this.user;
		return data;
	}
}