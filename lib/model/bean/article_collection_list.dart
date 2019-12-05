
import 'article_collection_list_item.dart';

class ArticleCollectionList {
    List<ArticleCollectionListItem> list;
    int next;

    ArticleCollectionList({this.list, this.next});

    factory ArticleCollectionList.fromJson(Map<String, dynamic> json) {
        return ArticleCollectionList(
            list: json['list'] != null ? (json['list'] as List).map((i) => ArticleCollectionListItem.fromJson(i)).toList() : null,
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
