import 'package:all/model/bean/user_info.dart';

class ArticleCommentListItem {
  String article;
  int commentNum;
  String content;
  int id;
  bool isPraise;
  ArticleCommentListItem parent;
  int praiseNum;
  int time;
  UserInfo user;

  ArticleCommentListItem(
      {this.article,
      this.commentNum,
      this.content,
      this.id,
      this.isPraise,
      this.parent,
      this.praiseNum,
      this.time,
      this.user});

  factory ArticleCommentListItem.fromJson(Map<String, dynamic> json) {
    return ArticleCommentListItem(
      article: json['article'],
      commentNum: json['comment_num'],
      content: json['content'],
      id: json['id'],
      isPraise: json['is_praise'],
      parent: json['parent'] != null
          ? ArticleCommentListItem.fromJson(json['parent'])
          : null,
      praiseNum: json['praise_num'],
      time: json['time'],
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article'] = this.article;
    data['comment_num'] = this.commentNum;
    data['content'] = this.content;
    data['id'] = this.id;
    data['is_praise'] = this.isPraise;
    data['praise_num'] = this.praiseNum;
    data['time'] = this.time;
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
