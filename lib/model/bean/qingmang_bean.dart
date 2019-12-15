class AppItem {
  List<AppChannel> channel;
  String contentType;
  Detail detail;
  int followCount;
  String icon;
  IconImage iconImage;
  int id;
  String idString;
  bool subscribed;
  bool supportRipple;
  String tagLine;
  String templateType;
  String title;
  bool userSaved = false;

  AppItem(
      {this.channel,
      this.contentType,
      this.detail,
      this.followCount,
      this.icon,
      this.iconImage,
      this.id,
      this.idString,
      this.subscribed,
      this.supportRipple,
      this.tagLine,
      this.templateType,
      this.title});

  factory AppItem.fromJson(Map<String, dynamic> json) {
    return AppItem(
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      detail: json['detail'] != null ? Detail.fromJson(json['detail']) : null,
      followCount: json['follow_count'],
      icon: json['icon'],
      iconImage: json['icon_image'] != null
          ? IconImage.fromJson(json['icon_image'])
          : null,
      id: json['id'],
      idString: json['id_string'],
      subscribed: json['subscribed'],
      supportRipple: json['support_ripple'],
      tagLine: json['tag_line'],
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['follow_count'] = this.followCount;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['subscribed'] = this.subscribed;
    data['support_ripple'] = this.supportRipple;
    data['tag_line'] = this.tagLine;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.iconImage != null) {
      data['icon_image'] = this.iconImage.toJson();
    }
    return data;
  }
}

class AppChannel {
  String contentType;
  int followCount;
  int id;
  String idString;
  bool subscribed;
  bool supportRipple;
  String title;

  AppChannel(
      {this.contentType,
      this.followCount,
      this.id,
      this.idString,
      this.subscribed,
      this.supportRipple,
      this.title});

  factory AppChannel.fromJson(Map<String, dynamic> json) {
    return AppChannel(
      contentType: json['content_type'],
      followCount: json['follow_count'],
      id: json['id'],
      idString: json['id_string'],
      subscribed: json['subscribed'],
      supportRipple: json['support_ripple'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['follow_count'] = this.followCount;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['subscribed'] = this.subscribed;
    data['support_ripple'] = this.supportRipple;
    data['title'] = this.title;
    return data;
  }
}

class ResultIcons {
  String px256;

  ResultIcons({this.px256});

  factory ResultIcons.fromJson(Map<String, dynamic> json) {
    return ResultIcons(
      px256: json['px256'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['px256'] = this.px256;
    return data;
  }
}

class MediaPressDetail {
  String app;
  String icon;
  String title;

  MediaPressDetail({this.app, this.icon, this.title});

  factory MediaPressDetail.fromJson(Map<String, dynamic> json) {
    return MediaPressDetail(
      app: json['app'],
      icon: json['icon'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app'] = this.app;
    data['icon'] = this.icon;
    data['title'] = this.title;
    return data;
  }
}

class IconImage {
  int rgbs;
  String url;

  IconImage({this.rgbs, this.url});

  factory IconImage.fromJson(Map<String, dynamic> json) {
    return IconImage(
      rgbs: json['rgbs'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rgbs'] = this.rgbs;
    data['url'] = this.url;
    return data;
  }
}

class ApplicationDetail {
  List<AppChannel> channel;
  String contentType;
  Detail detail;
  int followCount;
  String icon;
  IconImage iconImage;
  int id;
  String idString;
  bool subscribed;
  bool supportRipple;
  String tagLine;
  String templateType;
  String title;

  ApplicationDetail(
      {this.channel,
      this.contentType,
      this.detail,
      this.followCount,
      this.icon,
      this.iconImage,
      this.id,
      this.idString,
      this.subscribed,
      this.supportRipple,
      this.tagLine,
      this.templateType,
      this.title});

  factory ApplicationDetail.fromJson(Map<String, dynamic> json) {
    return ApplicationDetail(
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      detail: json['detail'] != null ? Detail.fromJson(json['detail']) : null,
      followCount: json['follow_count'],
      icon: json['icon'],
      iconImage: json['icon_image'] != null
          ? IconImage.fromJson(json['icon_image'])
          : null,
      id: json['id'],
      idString: json['id_string'],
      subscribed: json['subscribed'],
      supportRipple: json['support_ripple'],
      tagLine: json['tag_line'],
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['follow_count'] = this.followCount;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['subscribed'] = this.subscribed;
    data['support_ripple'] = this.supportRipple;
    data['tag_line'] = this.tagLine;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.iconImage != null) {
      data['icon_image'] = this.iconImage.toJson();
    }
    return data;
  }
}

class Detail {
  AppDetail appDetail;
  IosAppDetail iosAppDetail;
  MediaPressDetail mediaPressDetail;

  Detail({this.appDetail, this.iosAppDetail, this.mediaPressDetail});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      appDetail: json['app_detail'] != null
          ? AppDetail.fromJson(json['app_detail'])
          : null,
      iosAppDetail: json['ios_app_detail'] != null
          ? IosAppDetail.fromJson(json['ios_app_detail'])
          : null,
      mediaPressDetail: json['media_press_detail'] != null
          ? MediaPressDetail.fromJson(json['media_press_detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appDetail != null) {
      data['app_detail'] = this.appDetail.toJson();
    }
    if (this.iosAppDetail != null) {
      data['ios_app_detail'] = this.iosAppDetail.toJson();
    }
    if (this.mediaPressDetail != null) {
      data['media_press_detail'] = this.mediaPressDetail.toJson();
    }
    return data;
  }
}

class IosAppDetail {
  String icon;
  String iosSchema;
  String itunesDownloadUrl;
  String title;

  IosAppDetail({this.icon, this.iosSchema, this.itunesDownloadUrl, this.title});

  factory IosAppDetail.fromJson(Map<String, dynamic> json) {
    return IosAppDetail(
      icon: json['icon'],
      iosSchema: json['ios_schema'],
      itunesDownloadUrl: json['itunes_download_url'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['ios_schema'] = this.iosSchema;
    data['itunes_download_url'] = this.itunesDownloadUrl;
    data['title'] = this.title;
    return data;
  }
}

class AppDetail {
  List<Apk> apk;
  AppColor appColor;
  String appPlatform;
  String detailParam;
  String editorComment;
  ResultIcons icons;
  int id;
  String installedCountStr;
  int likesRate;
  String packageName;
  String tagLine;
  String title;

  AppDetail(
      {this.apk,
      this.appColor,
      this.appPlatform,
      this.detailParam,
      this.editorComment,
      this.icons,
      this.id,
      this.installedCountStr,
      this.likesRate,
      this.packageName,
      this.tagLine,
      this.title});

  factory AppDetail.fromJson(Map<String, dynamic> json) {
    return AppDetail(
      apk: json['apk'] != null
          ? (json['apk'] as List).map((i) => Apk.fromJson(i)).toList()
          : null,
      appColor: json['app_color'] != null
          ? AppColor.fromJson(json['app_color'])
          : null,
      appPlatform: json['app_platform'],
      detailParam: json['detail_param'],
      editorComment: json['editor_comment'],
      icons: json['icons'] != null ? ResultIcons.fromJson(json['icons']) : null,
      id: json['id'],
      installedCountStr: json['installed_count_str'],
      likesRate: json['likes_rate'],
      packageName: json['package_name'],
      tagLine: json['tagline'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail_param'] = this.detailParam;
    data['editor_comment'] = this.editorComment;
    data['app_platform'] = this.appPlatform;
    data['id'] = this.id;
    data['installed_count_str'] = this.installedCountStr;
    data['likes_rate'] = this.likesRate;
    data['package_name'] = this.packageName;
    data['tagline'] = this.tagLine;
    data['title'] = this.title;
    if (this.apk != null) {
      data['apk'] = this.apk.map((v) => v.toJson()).toList();
    }
    if (this.appColor != null) {
      data['app_color'] = this.appColor.toJson();
    }
    if (this.icons != null) {
      data['icons'] = this.icons.toJson();
    }
    return data;
  }
}

class Apk {
  int bytes_;
  int compatible;
  DownloadUrl downloadUrl;
  String md5;
  String paidType;
  int superior;
  int verified;
  int versionCode;
  String versionName;

  Apk(
      {this.bytes_,
      this.compatible,
      this.downloadUrl,
      this.md5,
      this.paidType,
      this.superior,
      this.verified,
      this.versionCode,
      this.versionName});

  factory Apk.fromJson(Map<String, dynamic> json) {
    return Apk(
      bytes_: json['bytes_'],
      compatible: json['compatible'],
      downloadUrl: json['download_url'] != null
          ? DownloadUrl.fromJson(json['download_url'])
          : null,
      md5: json['md5'],
      paidType: json['paid_type'],
      superior: json['superior'],
      verified: json['verified'],
      versionCode: json['version_code'],
      versionName: json['version_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bytes_'] = this.bytes_;
    data['compatible'] = this.compatible;
    data['md5'] = this.md5;
    data['paid_type'] = this.paidType;
    data['superior'] = this.superior;
    data['verified'] = this.verified;
    data['version_code'] = this.versionCode;
    data['version_name'] = this.versionName;
    if (this.downloadUrl != null) {
      data['download_url'] = this.downloadUrl.toJson();
    }
    return data;
  }
}

class DownloadUrl {
  String url;

  DownloadUrl({this.url});

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class AppColor {
  int normal;
  int pressed;

  AppColor({this.normal, this.pressed});

  factory AppColor.fromJson(Map<String, dynamic> json) {
    return AppColor(
      normal: json['normal'],
      pressed: json['pressed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['normal'] = this.normal;
    data['pressed'] = this.pressed;
    return data;
  }
}

class SubEntry {
  Action action;
  bool allowSaveImage;
  bool allowShareImage;
  Author author;
  List<AppChannel> channel;
  String contentType;
  List<Cover> cover;
  int coverTotalCount;
  int datePublished;
  String detailUrl;
  int id;
  String idString;
  List<ResultImage> image;
  List<ResultVideo> video;
  int imageTotalCount;
  bool isImage;
  bool isShortVideo;
  String reviewName;
  String snippet;
  List<Tag> tag;
  String templateType;
  String title;

  SubEntry(
      {this.action,
      this.allowSaveImage,
      this.allowShareImage,
      this.author,
      this.channel,
      this.contentType,
      this.cover,
      this.coverTotalCount,
      this.datePublished,
      this.detailUrl,
      this.id,
      this.idString,
      this.image,
      this.video,
      this.imageTotalCount,
      this.isImage,
      this.isShortVideo,
      this.reviewName,
      this.snippet,
      this.tag,
      this.templateType,
      this.title});

  factory SubEntry.fromJson(Map<String, dynamic> json) {
    return SubEntry(
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
      allowSaveImage: json['allow_save_image'],
      allowShareImage: json['allow_share_image'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      cover: json['cover'] != null
          ? (json['cover'] as List).map((i) => Cover.fromJson(i)).toList()
          : null,
      coverTotalCount: json['cover_total_count'],
      datePublished: json['datePublished'],
      detailUrl: json['detail_url'],
      id: json['id'],
      idString: json['id_string'],
      image: json['image'] != null
          ? (json['image'] as List).map((i) => ResultImage.fromJson(i)).toList()
          : null,
      video: json['video'] != null
          ? (json['video'] as List).map((i) => ResultVideo.fromJson(i)).toList()
          : null,
      imageTotalCount: json['image_total_count'],
      isImage: json['is_image'],
      isShortVideo: json['is_short_video'],
      reviewName: json['review_name'],
      snippet: json['snippet'],
      tag: json['tag'] != null
          ? (json['tag'] as List).map((i) => Tag.fromJson(i)).toList()
          : null,
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_save_image'] = this.allowSaveImage;
    data['allow_share_image'] = this.allowShareImage;
    data['content_type'] = this.contentType;
    data['cover_total_count'] = this.coverTotalCount;
    data['datePublished'] = this.datePublished;
    data['detail_url'] = this.detailUrl;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['image_total_count'] = this.imageTotalCount;
    data['is_image'] = this.isImage;
    data['is_short_video'] = this.isShortVideo;
    data['review_name'] = this.reviewName;
    data['snippet'] = this.snippet;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.action != null) {
      data['action'] = this.action.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.cover != null) {
      data['cover'] = this.cover.map((v) => v.toJson()).toList();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video.map((v) => v.toJson()).toList();
    }
    if (this.tag != null) {
      data['tag'] = this.tag.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Author {
  String name;

  Author({this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Tag {
  int tagId;
  String tagName;

  Tag({this.tagId, this.tagName});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      tagId: json['tag_id'],
      tagName: json['tag_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}

class Cover {
  int height;
  int rgbs;
  String url;
  int width;

  Cover({this.height, this.rgbs, this.url, this.width});

  factory Cover.fromJson(Map<String, dynamic> json) {
    return Cover(
      height: json['height'],
      rgbs: json['rgbs'],
      url: json['url'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['rgbs'] = this.rgbs;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

class ResultImage {
  int height;
  int rgbs;
  String url;
  int width;

  ResultImage({this.height, this.rgbs, this.url, this.width});

  factory ResultImage.fromJson(Map<String, dynamic> json) {
    return ResultImage(
      height: json['height'],
      rgbs: json['rgbs'],
      url: json['url'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['rgbs'] = this.rgbs;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

class Action {
  int type;
  String url;

  Action({this.type, this.url});

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class FavoriteSummary {
  int totalCount;

  FavoriteSummary({this.totalCount});

  factory FavoriteSummary.fromJson(Map<String, dynamic> json) {
    return FavoriteSummary(
      totalCount: json['total_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    return data;
  }
}

class ShareSummary {
  int totalCount;

  ShareSummary({this.totalCount});

  factory ShareSummary.fromJson(Map<String, dynamic> json) {
    return ShareSummary(
      totalCount: json['total_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    return data;
  }
}

class ArticleListItem {
  List<AppChannel> channel;
  String contentType;
  Detail detail;
  int followCount;
  String icon;
  IconImage iconImage;
  int id;
  String idString;
  List<SubEntry> subEntry;
  bool subscribed;
  bool supportRipple;
  String tagLine;
  String templateType;
  String title;

  ArticleListItem({
    this.channel,
    this.contentType,
    this.detail,
    this.followCount,
    this.icon,
    this.iconImage,
    this.id,
    this.idString,
    this.subEntry,
    this.subscribed,
    this.supportRipple,
    this.tagLine,
    this.templateType,
    this.title,
  });

  factory ArticleListItem.fromJson(Map<String, dynamic> json) {
    return ArticleListItem(
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      detail: json['detail'] != null ? Detail.fromJson(json['detail']) : null,
      followCount: json['follow_count'],
      icon: json['icon'],
      iconImage: json['icon_image'] != null
          ? IconImage.fromJson(json['icon_image'])
          : null,
      id: json['id'],
      idString: json['id_string'],
      subEntry: json['sub_entity'] != null
          ? (json['sub_entity'] as List)
              .map((i) => SubEntry.fromJson(i))
              .toList()
          : null,
      subscribed: json['subscribed'],
      supportRipple: json['support_ripple'],
      tagLine: json['tag_line'],
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['follow_count'] = this.followCount;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['subscribed'] = this.subscribed;
    data['support_ripple'] = this.supportRipple;
    data['tag_line'] = this.tagLine;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.iconImage != null) {
      data['icon_image'] = this.iconImage.toJson();
    }
    if (this.subEntry != null) {
      data['sub_entity'] = this.subEntry.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provider {
  List<AppChannel> channel;
  String contentType;
  Detail detail;
  int followCount;
  String icon;
  IconImage iconImage;
  int id;
  String idString;
  bool subscribed;
  bool supportRipple;
  String tagLine;
  String templateType;
  String title;

  Provider(
      {this.channel,
      this.contentType,
      this.detail,
      this.followCount,
      this.icon,
      this.iconImage,
      this.id,
      this.idString,
      this.subscribed,
      this.supportRipple,
      this.tagLine,
      this.templateType,
      this.title});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      detail: json['detail'] != null ? Detail.fromJson(json['detail']) : null,
      followCount: json['follow_count'],
      icon: json['icon'],
      iconImage: json['icon_image'] != null
          ? IconImage.fromJson(json['icon_image'])
          : null,
      id: json['id'],
      idString: json['id_string'],
      subscribed: json['subscribed'],
      supportRipple: json['support_ripple'],
      tagLine: json['tag_line'],
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_type'] = this.contentType;
    data['follow_count'] = this.followCount;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['subscribed'] = this.subscribed;
    data['support_ripple'] = this.supportRipple;
    data['tag_line'] = this.tagLine;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.iconImage != null) {
      data['icon_image'] = this.iconImage.toJson();
    }
    return data;
  }
}

class DetailArticle {
  DetailArticleDetail articleDetail;

  DetailArticle({this.articleDetail});

  factory DetailArticle.fromJson(Map<String, dynamic> json) {
    return DetailArticle(
      articleDetail: json['article_detail'] != null
          ? DetailArticleDetail.fromJson(json['article_detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articleDetail != null) {
      data['article_detail'] = this.articleDetail.toJson();
    }
    return data;
  }
}

class DetailArticleDetail {
  String author;
  String contentHtml;
  bool isAd;
  int publishedDate;

  DetailArticleDetail(
      {this.author, this.contentHtml, this.isAd, this.publishedDate});

  factory DetailArticleDetail.fromJson(Map<String, dynamic> json) {
    return DetailArticleDetail(
      author: json['author'],
      contentHtml: json['content_html'],
      isAd: json['is_ad'],
      publishedDate: json['published_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['content_html'] = this.contentHtml;
    data['is_ad'] = this.isAd;
    data['published_date'] = this.publishedDate;
    return data;
  }
}

class ArticleDetail {
  Action action;
  bool allowSaveImage;
  bool allowShareImage;
  Author author;
  List<AppChannel> channel;
  String contentType;
  int coverTotalCount;
  int datePublished;
  DetailArticle detail;
  FavoriteSummary favoriteSummary;
  String icon;
  IconImage iconImage;
  int id;
  String idString;
  bool isImage;
  bool isShortVideo;
  Provider provider;
  String reviewName;
  String snippet;
  String summary;
  String templateType;
  String title;

  ArticleDetail(
      {this.action,
      this.allowSaveImage,
      this.allowShareImage,
      this.author,
      this.channel,
      this.contentType,
      this.coverTotalCount,
      this.datePublished,
      this.detail,
      this.favoriteSummary,
      this.icon,
      this.iconImage,
      this.id,
      this.idString,
      this.isImage,
      this.isShortVideo,
      this.provider,
      this.reviewName,
      this.snippet,
      this.summary,
      this.templateType,
      this.title});

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
      action: json['action'] != null ? Action.fromJson(json['action']) : null,
      allowSaveImage: json['allow_save_image'],
      allowShareImage: json['allow_share_image'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      channel: json['channel'] != null
          ? (json['channel'] as List)
              .map((i) => AppChannel.fromJson(i))
              .toList()
          : null,
      contentType: json['content_type'],
      coverTotalCount: json['cover_total_count'],
      datePublished: json['datePublished'],
      detail: json['detail'] != null
          ? DetailArticle.fromJson(json['detail'])
          : null,
      favoriteSummary: json['favorite_summary'] != null
          ? FavoriteSummary.fromJson(json['favorite_summary'])
          : null,
      icon: json['icon'],
      iconImage: json['icon_image'] != null
          ? IconImage.fromJson(json['icon_image'])
          : null,
      id: json['id'],
      idString: json['id_string'],
      isImage: json['is_image'],
      isShortVideo: json['is_short_video'],
      provider:
          json['provider'] != null ? Provider.fromJson(json['provider']) : null,
      reviewName: json['review_name'],
      snippet: json['snippet'],
      summary: json['summary'],
      templateType: json['template_type'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow_save_image'] = this.allowSaveImage;
    data['allow_share_image'] = this.allowShareImage;
    data['content_type'] = this.contentType;
    data['cover_total_count'] = this.coverTotalCount;
    data['datePublished'] = this.datePublished;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['id_string'] = this.idString;
    data['is_image'] = this.isImage;
    data['is_short_video'] = this.isShortVideo;
    data['review_name'] = this.reviewName;
    data['snippet'] = this.snippet;
    data['summary'] = this.summary;
    data['template_type'] = this.templateType;
    data['title'] = this.title;
    if (this.action != null) {
      data['action'] = this.action.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.channel != null) {
      data['channel'] = this.channel.map((v) => v.toJson()).toList();
    }
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    if (this.favoriteSummary != null) {
      data['favorite_summary'] = this.favoriteSummary.toJson();
    }
    if (this.iconImage != null) {
      data['icon_image'] = this.iconImage.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    return data;
  }
}

class ResultVideo {
  List<String> cover;
  int duration;
  int height;
  String url;
  int width;

  ResultVideo({this.cover, this.duration, this.height, this.url, this.width});

  factory ResultVideo.fromJson(Map<String, dynamic> json) {
    return ResultVideo(
      cover:
          json['cover'] != null ? new List<String>.from(json['cover']) : null,
      duration: json['duration'],
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    if (this.cover != null) {
      data['cover'] = this.cover;
    }
    return data;
  }
}

class ArticleContentItem {
  String id;
  ResultText text;
  ResultContentImage image;
  ResultMedia media;
  Li li;
  int blockQuote;
  int type;

  ArticleContentItem({this.id, this.text, this.type, this.image, this.media, this.li, this.blockQuote});

  factory ArticleContentItem.fromJson(Map<String, dynamic> json) {
    return ArticleContentItem(
      id: json['id'],
      text: json['text'] != null ? ResultText.fromJson(json['text']) : null,
      image: json['image'] != null ? ResultContentImage.fromJson(json['image']) : null,
      media: json['media'] != null ? ResultMedia.fromJson(json['media']) : null,
      type: json['type'],
      li: json['li'] != null ? Li.fromJson(json['li']) : null,
      blockQuote: json['blockquote']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['blockquote'] = this.blockQuote;
    if (this.text != null) {
      data['text'] = this.text.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.li != null) {
      data['li'] = li.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    return data;
  }
}

class ResultText {
  List<Markup> markups;
  String lineType;
  String alignment;
  String text;

  ResultText({this.markups, this.text, this.lineType, this.alignment});

  factory ResultText.fromJson(Map<String, dynamic> json) {
    return ResultText(
      markups: json['markups'] != null
          ? (json['markups'] as List).map((i) => Markup.fromJson(i)).toList()
          : null,
      lineType: json['linetype'],
      text: json['text'],
      alignment: json['align']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['linetype'] = this.lineType;
    data['align'] = this.alignment;
    if (this.markups != null) {
      data['markups'] = this.markups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Markup {
  int end;
  int height;
  String source;
  int start;
  String tag;
  int width;

  Markup(
      {this.end, this.height, this.source, this.start, this.tag, this.width});

  factory Markup.fromJson(Map<String, dynamic> json) {
    return Markup(
      end: json['end'],
      height: json['height'],
      source: json['source'],
      start: json['start'],
      tag: json['tag'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end'] = this.end;
    data['height'] = this.height;
    data['source'] = this.source;
    data['start'] = this.start;
    data['tag'] = this.tag;
    data['width'] = this.width;
    return data;
  }
}

class ResultContentImage {
    int height;
    bool isInline;
    String source;
    int width;

    ResultContentImage({this.height, this.isInline, this.source, this.width});

    factory ResultContentImage.fromJson(Map<String, dynamic> json) {
        return ResultContentImage(
            height: json['height'],
            isInline: json['isInline'],
            source: json['source'],
            width: json['width'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['isInline'] = this.isInline;
        data['source'] = this.source;
        data['width'] = this.width;
        return data;
    }
}

class Li {
    int level;
    int order;
    String type;

    Li({this.level, this.order, this.type});

    factory Li.fromJson(Map<String, dynamic> json) {
        return Li(
            level: json['level'],
            order: json['order'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['level'] = this.level;
        data['order'] = this.order;
        data['type'] = this.type;
        return data;
    }
}

class ResultMedia {
    String cover;
    String source;
    String title;

    ResultMedia({this.cover, this.source, this.title});

    factory ResultMedia.fromJson(Map<String, dynamic> json) {
        return ResultMedia(
            cover: json['cover'],
            source: json['source'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cover'] = this.cover;
        data['source'] = this.source;
        data['title'] = this.title;
        return data;
    }
}