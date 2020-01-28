import 'package:all/model/bean/qingmang_bean.dart';

typedef OnAppItemTapCallback = void Function(AppItem item);

//typedef OnArticleItemTapWithList = Function(
//	ArticleListItem item, List<ArticleListItem> list);

typedef OnArticleItemTap = Function(ArticleListItem item);

typedef OnAppChannelMoreTap = Function(AppChannel channel);

typedef OnLoadingMore = Function();

typedef OnLinkPress = void Function(String url);

typedef OnImagePress = void Function(
	List<String> imageList, String image, List<double> imagePositionList);