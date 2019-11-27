
import 'article_detail_content_item.dart';

class ArticleListItem {
    String age;
    String author;
    String category;
    List<ArticleDetailContentItem> content;
    String date;
    String forward;
    String icon;
    String id;
    String image;
    List<String> imgList;
    String next;
    String openType;
    String originalUrl;
    String otherInfo;
    String pictureAuthor;
    String timeMillis;
    String title;
    String type;
    String video;
    String wordAuthor;

    ArticleListItem({this.age, this.author, this.category, this.content,
      this.date, this.forward, this.icon, this.id, this.image, this.imgList,
      this.next, this.openType, this.originalUrl, this.otherInfo,
      this.pictureAuthor, this.timeMillis, this.title, this.type,
      this.video, this.wordAuthor});

    factory ArticleListItem.fromJson(Map<String, dynamic> json) {
        return ArticleListItem(
            age: json['age'],
            author: json['author'],
            category: json['category'],
            content: json['content'] != null ? (json['content'] as List).map((i) => ArticleDetailContentItem.fromJson(i)).toList() : null,
            date: json['date'],
            forward: json['forward'],
            icon: json['icon'],
            id: json['id'],
            image: json['image'],
            imgList: json['img_list'] != null ? new List<String>.from(json['img_list']) : null,
            next: json['next'],
            openType: json['open_type'],
            originalUrl: json['original_url'],
            otherInfo: json['other_info'],
            pictureAuthor: json['pic_author'],
            timeMillis: json['time_millis'],
            title: json['title'],
            type: json['type'],
            video: json['video'],
            wordAuthor: json['word_author'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['age'] = this.age;
        data['author'] = this.author;
        data['category'] = this.category;
        data['date'] = this.date;
        data['forward'] = this.forward;
        data['icon'] = this.icon;
        data['id'] = this.id;
        data['image'] = this.image;
        data['next'] = this.next;
        data['open_type'] = this.openType;
        data['original_url'] = this.originalUrl;
        data['other_info'] = this.otherInfo;
        data['pic_author'] = this.pictureAuthor;
        data['time_millis'] = this.timeMillis;
        data['title'] = this.title;
        data['type'] = this.type;
        data['video'] = this.video;
        data['word_author'] = this.wordAuthor;
        if (this.content != null) {
            data['content'] = this.content.map((v) => v.toJson()).toList();
        }
        if (this.imgList != null) {
            data['img_list'] = this.imgList;
        }
        return data;
    }
}