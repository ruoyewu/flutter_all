import 'article_list_item.dart';

@deprecated
class ArticleList {
    String category;
    String name;
    String next;
    List<ArticleListItem> list;

    ArticleList({this.category, this.list, this.name, this.next});

    factory ArticleList.fromJson(Map<String, dynamic> json) {
        return ArticleList(
            category: json['category'],
            list: json['list'] != null ? (json['list'] as List).map((i) => ArticleListItem.fromJson(i)).toList() : null,
            name: json['name'],
            next: json['next'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['category'] = this.category;
        data['name'] = this.name;
        data['next'] = this.next;
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

