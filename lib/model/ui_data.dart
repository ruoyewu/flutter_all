class UIData {
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_SETTING = "/setting";
  static const String ROUTE_USER = "/user";
  static const String ROUTE_APP = "/app";
  static const String ROUTE_ARTICLE_DETAIL = "/article_detail";

  static const int SIZE_FAB = 56;
  static const int OFFSET_DEFAULT = 16;

  static const String URL_BASE = "http://all.wuruoye.com/";
  static const String URL_API = "article/api";
  static const String URL_ARTICLE_LIST = "article/list_";
  static const String URL_ARTICLE_DETAIL = "article/detail";
}

enum ArticleOpenType {
  NONE,
  ARTICLE,
  ORIGINAL_URL,
  IMAGE,
  VIDEO
}

enum ArticleItemType {
  NONE,
  TEXT,
  IMAGE,
  VIDEO,
  H1,
  H2,
  LI,
  TEXT_CENTER,
  QUOTE,
  H3,
  ITALIC,
}