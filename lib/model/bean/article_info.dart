class ArticleInfo {
  int collectNum;
  int commentNum;
  int praiseNum;
  bool isCollect;
  bool isPraise;

  ArticleInfo(
      {this.collectNum,
      this.commentNum,
      this.isCollect,
      this.isPraise,
      this.praiseNum});

  factory ArticleInfo.fromJson(Map<String, dynamic> json) {
    return ArticleInfo(
      collectNum: json['collect_num'],
      commentNum: json['comment_num'],
      isCollect: json['is_collect'],
      isPraise: json['is_praise'],
      praiseNum: json['praise_num'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collect_num'] = this.collectNum;
    data['comment_num'] = this.commentNum;
    data['is_collect'] = this.isCollect;
    data['is_praise'] = this.isPraise;
    data['praise_num'] = this.praiseNum;
    return data;
  }
}
