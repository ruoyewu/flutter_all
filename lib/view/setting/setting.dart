import 'package:all/base/base_state.dart';
import 'package:all/model/model/article_list_type_model.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/contract/setting_contract.dart';
import 'package:all/presenter/setting_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/article_list.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends BaseState<SettingPage, ISettingPresenter>
    implements ISettingView {

  UserTextTheme _userTextTheme;

  @override
  void initState() {
    super.initState();
    presenter = SettingPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  @override
  Widget buildBody(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            ..._buildArticleListType(),
        ],
      ),
    );
  }

  List<Widget> _buildArticleListType() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          '展示类型',
          style: _userTextTheme.itemTitle,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ProviderConsumer<ArticleListTypeModel>(
                presenter.articleListTypeModel,
                  (context, model, _) {
                  return ListView.builder(
                    itemCount: model.list?.length?? 0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ArticleListItemWidget(
                        model.list[index],
                        type: index,
                        onArticleItemTap: () {

                        },
                      );
                    },
                  );
                }
              ),
            ),
          ),
        ],
      )
    ];
  }
}
