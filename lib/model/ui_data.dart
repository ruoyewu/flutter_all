import 'dart:ui';

class UIData {
  static const ROUTE_HOME = "/home";
  static const ROUTE_SETTING = "/setting";
  static const ROUTE_USER = "/user";
  static const ROUTE_APP = "/app";
  static const ROUTE_ARTICLE_DETAIL = "/article_detail";
  static const ROUTE_WEB = "/web";
  static const ROUTE_IMAGE = '/img';
  static const ROUTE_LOGIN = '/login';

  static const SIZE_FAB = 56;
  static const OFFSET_DEFAULT = 16;

  static const COLOR_CRAIL = Color(0xFFB94C40);
  static const COLOR_MOUNTAIN_MIST = Color(0xFF959595);
  static const COLOR_MONSOON = Color(0xFF787878);
  static const COLOR_MERCURY = Color(0xFFE7E5E5);

  // net
  static const URL_BASE = "http://all.wuruoye.com/";
  static const URL_API = "article/api";
  static const URL_ARTICLE_LIST = "article/list_";
  static const URL_ARTICLE_DETAIL = "article/detail";
  static const URL_LOGIN = "user/login";
  static const URL_LOGOUT = 'user/logout';
  static const URL_USER = 'user/user';
  static const URL_ARTICLE_INFO = 'user/article_info';
  static const URL_ARTICLE_PRAISE = 'user/article_praise';
  static const URL_ARTICLE_COLLECT = 'user/article_collect';
  static const URL_ARTICLE_COMMENT = 'user/article_comment';
  static const URL_PRAISE_COMMENT = 'user/comment_praise';
  static const URL_VERIFY_CODE = 'user/verify_code';
  static const URL_AVATAR = 'user/avatar';

  static const CODE_NOT_LOGIN = 401;
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