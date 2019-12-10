import 'dart:ui';

class UIData {
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_SETTING = "/setting";
  static const String ROUTE_USER = "/user";
  static const String ROUTE_APP = "/app";
  static const String ROUTE_ARTICLE_DETAIL = "/article_detail";
  static const String ROUTE_WEB = "/web";
  static const String ROUTE_HTML = "/html";
  static const String ROUTE_LOGIN = '/login';

  static const int SIZE_FAB = 56;
  static const int OFFSET_DEFAULT = 16;

  static const Color COLOR_CRAIL = Color(0xFFB94C40);
  static const Color COLOR_MOUNTAIN_MIST = Color(0xFF959595);
  static const Color COLOR_MONSOON = Color(0xFF787878);
  static const Color COLOR_MERCURY = Color(0xFFE7E5E5);

  // net
  static const String URL_BASE = "http://all.wuruoye.com/";
//  static const String URL_BASE = "http://10.91.40.143:3421/";
  static const String URL_API = "article/api";
  static const String URL_ARTICLE_LIST = "article/list_";
  static const String URL_ARTICLE_DETAIL = "article/detail";
  static const String URL_LOGIN = "user/login";
  static const String URL_LOGOUT = 'user/logout';
  static const String URL_USER = 'user/user';
  static const String URL_ARTICLE_INFO = 'user/article_info';
  static const String URL_ARTICLE_PRAISE = 'user/article_praise';
  static const String URL_ARTICLE_COLLECT = 'user/article_collect';
  static const String URL_ARTICLE_COMMENT = 'user/article_comment';
  static const String URL_PRAISE_COMMENT = 'user/comment_praise';
  static const String URL_VERIFY_CODE = 'user/verify_code';
  static const String URL_AVATAR = 'user/avatar';

  static const int CODE_NOT_LOGIN = 401;
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