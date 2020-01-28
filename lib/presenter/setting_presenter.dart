import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_type_model.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/setting_contract.dart';

class SettingPresenter extends ISettingPresenter {
  SettingPresenter(ISettingView view) : super(view);

  ArticleListTypeModel _articleListTypeModel;

  @override
  void initModel() async {
    _articleListTypeModel = ArticleListTypeModel();
    int type = await UserSetting.articleListType.value;
    _articleListTypeModel.type = type;
    _articleListTypeModel.list = List.filled(
        2,
        ArticleListItem(
          subEntry: [
            SubEntry(
              author: Author(name: 'Author'),
              cover: [
                Cover(
                  url: '',
                )
              ],
              snippet:
                  '这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言这是一段前言',
              tag: [Tag(tagName: '标签')],
              title: '这是一段标题这是一段标题这是一段标题这是一段标题这是一段标题这是一段标题这是一段标题',
              datePublished: DateTime.now().millisecond,
            )
          ],
          title: '一个',
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _articleListTypeModel.dispose();
  }

  @override
  ArticleListTypeModel get articleListTypeModel => _articleListTypeModel;

  @override
  startSetArticleListType(int type) async {
    UserSetting.articleListType.val = type;
  }
}
