import 'dart:developer';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart' hide ResultIcons;
import 'package:all/model/model/home_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/presenter/home_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/home/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage, IHomePresenter>
    with SingleTickerProviderStateMixin
    implements IHomeView {
  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(this);
    presenter.startRefresh();
    presenter.startDefaultLogin();
  }

  @override
  void showDialog(String msg) {
    log(msg);
  }

  @override
  TickerProvider get tickerProvider => this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ALL"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch<String>(
                    context: context, delegate: SearchWidget(presenter)).then((result) {
                      presenter.startRefresh();
                });
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            container(context),
            buttons(context),
          ],
        ));
  }

  Widget container(BuildContext context) {
    return ProviderConsumer<HomeListModel>(
        presenter.homeListModel,
        (context, model, _) => HomeListWidget(
          model.appItemList,
              onItemTap: (AppItem item) {
                Navigator.pushNamed(context, UIData.ROUTE_APP,
                    arguments: item);
              },
            ));
  }

  Widget buttons(BuildContext context) {
    return SizedBox.expand(
      child: ProviderConsumer<HomeFabAnimationModel>(
        presenter.homeFabAnimationModel,
        (context, model, _) => Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetSetting),
              child: FloatingActionButton(
                heroTag: "fab_setting",
                child: Icon(
                  Icons.settings,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UIData.ROUTE_HTML, arguments: {
                    'html': '''
<p>双12影音会员大促，优酷视频VIP会员、腾讯视频超级影视VIP限时4折大促，爱奇艺VIP会员、搜狐视频VIP会员、喜马拉雅FM会员限时5折大促。<br></p>
<table>
 <tbody>
  <tr>
   <td>会员</td>
   <td>原价/活动价<br></td>
   <td>购买</td>
  </tr>
  <tr>
   <td rowspan="1" colspan="3">优酷视频（截止至12日）</td>
  </tr>
  <tr>
   <td rowspan="2" colspan="1"><span>VIP会员年卡</span></td>
   <td rowspan="2" colspan="1">￥198/￥99送20元话费<br></td>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=5a85d8b7b45c4724a671536d6f1938fd&amp;pid=mm_128854259_41328591_511718837&amp;itemId=580872710397&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=6d2db5c998d54f2c859a6dbd9932e394&amp;pid=mm_128854259_41328591_511718837&amp;itemId=586614678228&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="1">VIP会员季卡</td>
   <td rowspan="1" colspan="1">￥58/￥28</td>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=6f426f3e73ee45deb582e9c272d24dd4&amp;pid=mm_128854259_41328591_511718837&amp;itemId=584399333079&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="1">VIP会员月卡×2张<br></td>
   <td rowspan="1" colspan="1">￥40/￥20</td>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=dfd43c79529c4a2b98074e70efabf89e&amp;pid=mm_128854259_41328591_511718837&amp;itemId=597431174152&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="3">爱奇艺（截止至13日）</td>
  </tr>
  <tr>
   <td rowspan="2" colspan="1"><span>VIP会员年卡</span></td>
   <td rowspan="2" colspan="1">￥198/￥99</td>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=e8d7852124e2446ea1c12f71fbe5e063&amp;pid=mm_128854259_41328591_511718837&amp;itemId=567466737990&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="1"><a href="https://s.click.taobao.com/KyCkYtv">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="3">腾讯视频（截止至12日）</td>
  </tr>
  <tr>
   <td rowspan="2"><span>超级影视VIP年卡</span></td>
   <td rowspan="2">￥488/￥198送月卡</td>
   <td width="31"><a href="https://uland.taobao.com/coupon/edetail?activityId=c33f15edfaa44b7b9645210c6b967178&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570739074093&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=ccf47dea8f7e4f219a7aa0f52fd80633&amp;pid=mm_128854259_41328591_511718837&amp;itemId=564977691189&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="2"><span>超级影视VIP年卡×2张</span></td>
   <td rowspan="2">￥976/￥396送季卡</td>
   <td width="30"><a href="https://uland.taobao.com/coupon/edetail?activityId=22301f99fb9e4396adf713949ca74ef1&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570730246681&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=0f39ffaaed5d426c97ccd60033e6e6b6&amp;pid=mm_128854259_41328591_511718837&amp;itemId=564880894617&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="2">超级影视VIP季卡</td>
   <td rowspan="2">￥148/￥59</td>
   <td width="30"><a href="https://uland.taobao.com/coupon/edetail?activityId=33317e7e18674b2690fbd35acc5841da&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570630133599&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=21a1d152b4ce4d79933bc2d6b5cedc0d&amp;pid=mm_128854259_41328591_511718837&amp;itemId=564893930171&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="2">超级影视VIP月卡</td>
   <td rowspan="2">￥50/￥20</td>
   <td width="30"><a href="https://uland.taobao.com/coupon/edetail?activityId=5a4358931f5044579aa9aa9902d12079&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570821071468&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=9a331a3c2bbc44e3a56b03555f275fc1&amp;pid=mm_128854259_41328591_511718837&amp;itemId=567269433966&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="3" rowspan="1">网易云音乐（截止至13日）</td>
  </tr>
  <tr>
   <td colspan="1" rowspan="2"><span>黑胶会员半年卡</span><br></td>
   <td colspan="1" rowspan="2">￥90/￥53.8</td>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=e7991ad082c6467a8b73d51fb2247d8b&amp;pid=mm_128854259_41328591_511718837&amp;itemId=598035030444&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=0853c8689d5c4a43aa0d639778c84040&amp;pid=mm_128854259_41328591_511718837&amp;itemId=602163932612&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="2">黑胶会员季卡</td>
   <td colspan="1" rowspan="2">￥45/￥30</td>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=d7d0494932d5481d87690c0ebb1cc256&amp;pid=mm_128854259_41328591_511718837&amp;itemId=579066626450&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=37486f4e1da2471b87d35dac02a94b31&amp;pid=mm_128854259_41328591_511718837&amp;itemId=601607839737&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="3" rowspan="1">搜狐视频（截止至15日）</td>
  </tr>
  <tr>
   <td colspan="1" rowspan="1"><span>VIP会员年卡</span></td>
   <td colspan="1" rowspan="1">￥198/￥95</td>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=61494cd2467e40ea856298f5a5569c8a&amp;pid=mm_128854259_41328591_511718837&amp;itemId=606186217203&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="1" colspan="3">喜马拉雅FM（截止至14日）</td>
  </tr>
  <tr>
   <td rowspan="2" colspan="1" width="313"><span>VIP会员年卡</span></td>
   <td rowspan="2" colspan="1" width="313">￥218/￥98</td>
   <td><a href="https://uland.taobao.com/coupon/edetail?activityId=1ed4323e8ccc475eaaa026fcf3a03b23&amp;pid=mm_128854259_41328591_511718837&amp;itemId=574183309675&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td><a href="https://uland.taobao.com/coupon/edetail?activityId=dd1133374b01496c93935eef68237c82&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570925932857&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td rowspan="2" colspan="1">VIP儿童会员年卡×2张</td>
   <td rowspan="2" colspan="1">￥398/￥198<br></td>
   <td rowspan="1" colspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=070ed72d7b3d481cbec9d35b75416822&amp;pid=mm_128854259_41328591_511718837&amp;itemId=596812907624&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td><a href="https://uland.taobao.com/coupon/edetail?activityId=07ebfa498ef64a309548dc68a056eb34&amp;pid=mm_128854259_41328591_511718837&amp;itemId=592133610987&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td colspan="3" rowspan="1">樊登读书（截止至31日）</td>
  </tr>
  <tr>
   <td colspan="1" rowspan="2">VIP会员年卡</td>
   <td colspan="1" rowspan="2">￥365/￥265</td>
   <td colspan="1" rowspan="1"><a href="https://uland.taobao.com/coupon/edetail?activityId=02c8780056b54fa0bc595db664cc454a&amp;pid=mm_128854259_41328591_511718837&amp;itemId=607145504759&amp;mt=1">点此</a></td>
  </tr>
  <tr>
   <td><a href="https://uland.taobao.com/coupon/edetail?activityId=03c393e3b3524e6c9f1419ecb0a9ee3d&amp;pid=mm_128854259_41328591_511718837&amp;itemId=607374163213&amp;mt=1">点此</a></td>
  </tr>
 </tbody>
</table>
<p>•&nbsp;注：部分活动有多个入口，可以分别购买多次。</p>
<p><strong>•&nbsp;优酷视频</strong></p>
<p><img src="http://qiniuimg.qingmang.mobi/image/orion/eade287f9e1e20ab88d5b9028c6b92d0_430_430.jpeg" original-width="430" original-height="430"></p>
<p>VIP会员：原价198元/年，可用于手机、电脑和Pad，限时79元/年（99元送20元话费），<a href="https://uland.taobao.com/coupon/edetail?activityId=5a85d8b7b45c4724a671536d6f1938fd&amp;pid=mm_128854259_41328591_511718837&amp;itemId=580872710397&amp;mt=1">点此购买</a>（年卡）；28元/3个月，<a href="https://uland.taobao.com/coupon/edetail?activityId=6f426f3e73ee45deb582e9c272d24dd4&amp;pid=mm_128854259_41328591_511718837&amp;itemId=584399333079&amp;mt=1">点此购买</a>（季卡）；20元/2个月，<a href="https://uland.taobao.com/coupon/edetail?activityId=dfd43c79529c4a2b98074e70efabf89e&amp;pid=mm_128854259_41328591_511718837&amp;itemId=597431174152&amp;mt=1">点此购买</a>（月卡2张）。</p>
<p><strong>•&nbsp;爱奇艺</strong></p>
<p><img src="http://qiniuimg.qingmang.mobi/image/orion/264a3b4dce71b5195dd6102c4f3df16c_430_430.jpeg" original-width="430" original-height="430"></p>
<p>VIP会员：原价198元/年，可用于手机、电脑和Pad，限时99元/年，<a href="https://uland.taobao.com/coupon/edetail?activityId=5a85d8b7b45c4724a671536d6f1938fd&amp;pid=mm_128854259_41328591_511718837&amp;itemId=580872710397&amp;mt=1">点此购买</a>（年卡）</p>
<p><strong>•&nbsp;腾讯视频</strong></p>
<p><img src="http://qiniuimg.qingmang.mobi/image/orion/9dc18a0874132806fc709428205bab44_430_430.jpeg" original-width="430" original-height="430"></p>
<p>超级影视VIP：原价488元/年，可用于TV、手机、电脑和Pad，限时198/年+送月卡，<a href="https://uland.taobao.com/coupon/edetail?activityId=c33f15edfaa44b7b9645210c6b967178&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570739074093&amp;mt=1">点此购买</a>（年卡）；59元/3个月，<a href="https://uland.taobao.com/coupon/edetail?activityId=33317e7e18674b2690fbd35acc5841da&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570630133599&amp;mt=1">点此购买</a>（季卡）；20元/1月，<a href="https://uland.taobao.com/coupon/edetail?activityId=5a4358931f5044579aa9aa9902d12079&amp;pid=mm_128854259_41328591_511718837&amp;itemId=570821071468&amp;mt=1">点此购买</a>（月卡）。</p>
  ''',
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetUser),
              child: FloatingActionButton(
                heroTag: "fab_user",
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UIData.ROUTE_USER);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: Transform.rotate(
                angle: model.rotateAdd,
                child: FloatingActionButton(
                  heroTag: "fab_add",
                  child: Icon(
                    Icons.add,
                    color: Colors.white70,
                  ),
                  onPressed: this.presenter.startFabAnimation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends SearchDelegate<String> {
  SearchWidget(this.presenter);

  IHomePresenter presenter;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.black,),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation, color: Colors.black,),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    presenter.startSearch(query);

    return ProviderConsumer<SearchAppModel>(presenter.searchAppModel,
        (context, model, _) {
      return Scrollbar(
        child: ListView.builder(
          itemCount: model.searchAppList.length,
          itemBuilder: (context, index) {
            AppItem app = model.searchAppList[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, UIData.ROUTE_APP, arguments: app);
//                presenter.startAddAppItem(app);
//                Widgets.showSnackBar(context, 'add app ${app.title}');
              },
              child: ListTile(
                title: Text(app.title),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(app.icon),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    const test = ['一个', '爱范', '好奇心', '36氪', 'sspai', '500'];

    return ListView.builder(
        itemCount: test.length * 10,
        itemBuilder: (context, index) {
          index = index % test.length;
          return InkWell(
            onTap: () {
              query = test[index];
              buildResults(context);
            },
            child: ListTile(
              title: Text(test[index]),
            ),
          );
        });
  }
}
