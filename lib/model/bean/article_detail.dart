
import 'package:all/model/bean/article_detail_content.dart';

@deprecated
class ArticleDetail {
    ArticleDetailContent content;
    String app;
    String category;
    String id;

    ArticleDetail({this.content, this.app, this.category, this.id});

    factory ArticleDetail.fromJson(Map<String, dynamic> json) {
        return ArticleDetail(
            content: json['data'] != null ? ArticleDetailContent.fromJson(json['data']) : null,
            app: json['app'], 
            category: json['category'], 
            id: json['id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['app'] = this.app;
        data['category'] = this.category;
        data['id'] = this.id;
        if (this.content != null) {
            data['data'] = this.content.toJson();
        }
        return data;
    }
}