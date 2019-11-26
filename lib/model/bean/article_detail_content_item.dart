
class ArticleDetailContentItem {
    String info;
    String type;

    ArticleDetailContentItem({this.info, this.type});

    factory ArticleDetailContentItem.fromJson(Map<String, dynamic> json) {
        return ArticleDetailContentItem(
            info: json['info'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['info'] = this.info;
        data['type'] = this.type;
        return data;
    }
}