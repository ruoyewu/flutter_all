
class ArticleListItem {
  String openType;
  String age;
  String author;
  String bgImg;
  String category;
  String date;
  String forward;
  String id;
  String image;
  String millis;
  String originalUrl;
  String otherInfo;
  String title;
  String type;
  String url;

  ArticleListItem({this.openType, this.age, this.author, this.bgImg,
    this.category, this.date, this.forward, this.id, this.image,
    this.millis, this.originalUrl, this.otherInfo, this.title,
    this.type, this.url});

  factory ArticleListItem.fromJson(Map<String, dynamic> json) {
    return ArticleListItem(
      openType: json['open'],
      age: json['age'],
      author: json['author'],
      bgImg: json['bg_img'],
      category: json['category'],
      date: json['date'],
      forward: json['forward'],
      id: json['id'],
      image: json['image'],
      millis: json['millis'],
      originalUrl: json['original_url'],
      otherInfo: json['other_info'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.openType;
    data['age'] = this.age;
    data['author'] = this.author;
    data['bg_img'] = this.bgImg;
    data['category'] = this.category;
    data['date'] = this.date;
    data['forward'] = this.forward;
    data['id'] = this.id;
    data['image'] = this.image;
    data['millis'] = this.millis;
    data['original_url'] = this.originalUrl;
    data['other_info'] = this.otherInfo;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}