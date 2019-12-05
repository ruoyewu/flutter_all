import 'article_comment_list_item.dart';

class ArticleCommentList {
  List<ArticleCommentListItem> list;
  int next;

  ArticleCommentList({this.list, this.next});

  removeWithId(int id) {
    if (list == null) return;
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        list.removeAt(i);
        return;
      }
    }
  }

  factory ArticleCommentList.fromJson(Map<String, dynamic> json) {
    return ArticleCommentList(
      list: json['list'] != null
          ? (json['list'] as List)
              .map((i) => ArticleCommentListItem.fromJson(i))
              .toList()
          : null,
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
