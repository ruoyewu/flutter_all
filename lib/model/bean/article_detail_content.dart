
import 'package:all/model/bean/article_detail_content_item.dart';

class ArticleDetailContent {
    String author;
    List<ArticleDetailContentItem> itemList;
    String date;
    List<String> serialList;
    String subtitle;
    String title;

    ArticleDetailContent({this.author, this.itemList, this.date, this.serialList, this.subtitle, this.title});

    factory ArticleDetailContent.fromJson(Map<String, dynamic> json) {
        return ArticleDetailContent(
            author: json['author'], 
            itemList: json['content'] != null ? (json['content'] as List).map((i) => ArticleDetailContentItem.fromJson(i)).toList() : null,
            date: json['date'], 
            serialList: json['serial_list'] != null ? new List<String>.from(json['serial_list']) : null,
            subtitle: json['subtitle'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['author'] = this.author;
        data['date'] = this.date;
        data['subtitle'] = this.subtitle;
        data['title'] = this.title;
        if (this.itemList != null) {
            data['content'] = this.itemList.map((v) => v.toJson()).toList();
        }
        if (this.serialList != null) {
            data['serial_list'] = this.serialList;
        }
        return data;
    }
}