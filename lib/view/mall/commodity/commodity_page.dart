import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_provide.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommodityPage extends PageProvideNode{
  final CommodityProvide _provide = CommodityProvide();
  MallPage(){
    mProviders.provide(Provider<CommodityProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return CommodityContent(_provide);
  }
}

class CommodityContent extends StatefulWidget {
  final CommodityProvide _provide;

  CommodityContent(this._provide);

  @override
  _CommodityContentState createState() => new _CommodityContentState();
}

class _CommodityContentState extends State<CommodityContent> with SingleTickerProviderStateMixin{

  TabController _tabController;

  EasyRefreshController _easyController;
  int _count=20;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Container(
          width: ScreenAdapter.width(ScreenAdapter.getScreenPxWidth()/5),
          child: _tabBar(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
      ),
      body: new Stack(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(
              top: ScreenAdapter.height(88.0)
            ),
            child: _tabBarView(),
          ),
          //307pt*20pt
          new Positioned(
              top: 5,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(20*ScreenAdapter.getPixelRatio()),
              child: new InkWell(
                onTap: (){
                  // 跳转到搜索页面
                  Navigator.pushNamed(context, "/mallSearchPage");
                },
                child: _searchWidget(),
              )
          )
        ],
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: mallTabBarList.length, vsync: this);
    _easyController= new EasyRefreshController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  /// 顶部导航栏组件
  Widget _tabBar(){
    return new TabBar(
        isScrollable: false,
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: new TextStyle(fontSize: 14.0),
        labelColor: Colors.black,
        labelStyle: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
        tabs: mallTabBarList.map((item){
          return new Container(
            width: ScreenAdapter.width(ScreenAdapter.getScreenPxWidth()/10),
            child: new Text(item.title),
          );
        }).toList()
    );
  }

  /// tabbarview视图组件
  Widget _tabBarView(){
    return new TabBarView(
        controller: _tabController,
        children: [
          new ListWidgetPage(
//            controller: _easyController,
            onRefresh:() async{
              await Future.delayed(Duration(seconds: 2), () {
                print('onRefresh');
                setState(() {
                  _count = 20;
                });
//                _easyController.resetLoadState();
              });
            },
            onLoad: () async{
              await Future.delayed(Duration(seconds: 2), () {
                print('onLoad');
                setState(() {
                  _count += 10;
                });
//                _easyController.finishLoad(noMore: _count >= 20);
              });
            },
            child: <Widget>[
              // 数据内容
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      child: Center(
                        child: Text('$index'),
                      ),
                      color: index%2==0 ? Colors.grey[300] : Colors.transparent,
                    );
                  },
                  childCount: _count,
                ),
              ),
            ],
          ),
          new ListWidgetPage()
        ]
    );
  }

  /// 搜索组件
  Widget _searchWidget(){
    return new Container(
      margin: EdgeInsets.only(left: 20,right: 50),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: AppConfig.assistLineColor,
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Image.asset("assets/images/search.png",width: 40,height: 40,),
          new Text("搜索商品、品牌、品类",style: TextStyle(color: AppConfig.assistFontColor),)
        ],
      ),
    );
  }
}