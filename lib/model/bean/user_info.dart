class UserInfo {
    String avatar;
    int createTime;
    String id;
    bool isAvailable;
    String name;
    String phone;
    String sign;

    UserInfo({this.avatar, this.createTime, this.id, this.isAvailable, this.name, this.phone, this.sign});

    factory UserInfo.fromJson(Map<String, dynamic> json) {
        return UserInfo(
            avatar: json['avatar'],
            createTime: json['create_time'],
            id: json['id'],
            isAvailable: json['is_available'],
            name: json['name'],
            phone: json['phone'],
            sign: json['sign'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar'] = this.avatar;
        data['create_time'] = this.createTime;
        data['id'] = this.id;
        data['is_available'] = this.isAvailable;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['sign'] = this.sign;
        return data;
    }
}