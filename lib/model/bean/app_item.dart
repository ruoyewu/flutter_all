
class AppItem {
    List<String> categories;
    List<String> titles;
    String icon;
    String name;
    String title;

    AppItem({this.categories, this.titles, this.icon, this.name, this.title});

    factory AppItem.fromJson(Map<String, dynamic> json) {
        return AppItem(
            categories: json['category_name'] != null ? new List<String>.from(json['category_name']) : null,
            titles: json['category_title'] != null ? new List<String>.from(json['category_title']) : null,
            icon: json['icon'],
            name: json['name'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['icon'] = this.icon;
        data['name'] = this.name;
        data['title'] = this.title;
        if (this.categories != null) {
            data['category_name'] = this.categories;
        }
        if (this.titles != null) {
            data['category_title'] = this.titles;
        }
        return data;
    }
}