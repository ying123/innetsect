import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class CommodityDetailPage extends PageProvideNode{

  final CommodityDetailProvide _provide = CommodityDetailProvide();

  CommodityDetailPage(){
    mProviders.provide(Provider<CommodityDetailProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return CommodityDetailContent(_provide);
  }
  
}

class CommodityDetailContent extends StatefulWidget {
  final CommodityDetailProvide _provide;
  CommodityDetailContent(this._provide);
  @override
  _CommodityDetailContentState createState() => new _CommodityDetailContentState();
}

class _CommodityDetailContentState extends State<CommodityDetailContent> with
    SingleTickerProviderStateMixin{

  TabController _tabController;
  ScrollController _scrollController ;

  @override
  Widget build(BuildContext context) {
    dynamic mapData = ModalRoute.of(context).settings.arguments;
    print(mapData);
    return new Scaffold(
      appBar: new AppBar(
        leading: new InkWell(
          onTap: (){
            // 返回
            Navigator.pop(context);
          },
          child: new Container(
            padding: EdgeInsets.all(20),
            child: new Image.asset("assets/images/mall/arrow_down.png",
              fit: BoxFit.fitWidth,
            )
          ),
        ),
        title: new Container(
          width: ScreenAdapter.width(220),
          child: _topNavTabBar(),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
      body: _tabBarView(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(length: detailTabBarList.length, vsync: this);
    _scrollController = new ScrollController();

    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        _tabController.index=1;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  /// 商品顶部导航
  Widget _topNavTabBar(){
    return new TabBar(
        isScrollable: false,
        controller: _tabController,
        indicatorColor: Colors.red,
        indicatorSize:TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: new TextStyle(fontSize: ScreenAdapter.size(24)),
        labelColor: Colors.black,
        labelStyle: new TextStyle(fontSize: ScreenAdapter.size(24)),
        tabs: detailTabBarList.map((item){
          return new Container(
            height: ScreenAdapter.height(40),
            width: ScreenAdapter.width(ScreenAdapter.getScreenPxWidth()/10),
            alignment: Alignment.center,
            child: new Text(item.title),
          );
        }).toList()
    );
  }

  /// tabBarView视图组件
  Widget _tabBarView(){
    return new TabBarView(
        controller: _tabController,
        children: [
          _contentWidget(),
          new Container(
            child: new Text("11"),
          ),
        ]
    );
  }

  /// 商品详情内容区域
  Widget _contentWidget(){
    return new Container(
      color: AppConfig.backGroundColor,
      child: new ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            _swiperWidget(),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: _comTitle(),
            ),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: _selCol(),
            ),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: _recommendWidget(),
            ),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: new Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: new Text("上拉显示商品详情",style: TextStyle(
                    fontSize: ScreenAdapter.size(26),
                    fontWeight: FontWeight.w600),
                ),
              )
            ),
            new Container(
              height: ScreenAdapter.height(100),
              color: Colors.white,
            )
          ],
        ),
    );
  }

  /// _swiperWidget
  Widget _swiperWidget(){
    return Container(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(563),
      color: Colors.white,
      child:new Swiper(
          itemBuilder: (BuildContext context,int index){
            return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
          },
          loop: true,
          itemCount: 3,
          pagination: new SwiperPagination(),
        )
      );
  }

  /// 标题
  Widget _comTitle(){
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("1111",style: TextStyle(fontSize: ScreenAdapter.size(38),
              fontWeight: FontWeight.w800
          ),),
          new Padding(padding: EdgeInsets.only(top: 10),
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 2),
                    alignment: Alignment.center,
                    child: new Text("¥ ",style: TextStyle(
                      fontSize: ScreenAdapter.size(24.0),),
                    ),
                  ),
                  new Container(
                      alignment: Alignment.center,
                      child: new Text("1111", style: TextStyle(
                          fontSize: ScreenAdapter.size(32.0),
                          fontWeight: FontWeight.bold
                        ),
                      )
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 已选栏目
  Widget _selCol(){
    return new Container(
      height: ScreenAdapter.height(98),
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: new Row(
        children: <Widget>[
          new Container(
            child: new Text("已选",style: TextStyle(fontSize: ScreenAdapter.size(28),fontWeight: FontWeight.w600),),
          ),
          new Container(
            width: ScreenAdapter.width(590),
            padding: EdgeInsets.only(left: 20,right: 20),
            child: new Text("劳斯莱斯 , M , 1件"),
          ),
          new Container(
            width: ScreenAdapter.width(66),
            alignment: Alignment.centerRight,
            child: new Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
  
  /// 推荐
  Widget _recommendWidget(){
    return Container(
      height: ScreenAdapter.height(300),
      color: Colors.cyanAccent,
    );
  }

  /// 底部：客服、购物车、加入购物车、立即购买
  Widget _bottomBar(){
    return new Container(
      height: ScreenAdapter.height(120),
      padding: EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 12),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _iconAndTextMerge(title:"客服",icon: "assets/images/mall/service_p_icon.png"),
//          new Padding(padding: EdgeInsets.only(left: 12),
//            child: _iconAndTextMerge(title:"心愿单",icon: "assets/images/mall/wish_icon.png")
//          ),
          new Padding(padding: EdgeInsets.only(left: 24),
            child: _iconAndTextMerge(title:"购物车",icon: "assets/images/mall/cart_icon.png")
          ),
          new Padding(padding: EdgeInsets.only(left: 17),
            child: new Container(
              width: ScreenAdapter.width(230),
              height: ScreenAdapter.height(90),
              color: Colors.black,
              alignment: Alignment.center,
              child: new Text("加入购物车",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
            ),
          ),
          new Padding(padding: EdgeInsets.only(left: 15),
            child: new Container(
              width: ScreenAdapter.width(230),
              height: ScreenAdapter.height(90),
              color: AppConfig.primaryColor,
              alignment: Alignment.center,
              child: new Text("立即购买",style: TextStyle(color: AppConfig.fontBackColor,
                  fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
            ),
          )
        ],
      ),
    );
  }

  /// 图片和文字结合，垂直布局
  Widget _iconAndTextMerge({title,icon}){
    return new Container(
      child: new Column(
        children: <Widget>[
          new Image.asset(icon,width: ScreenAdapter.width(40),height: ScreenAdapter.height(40),),
          new Padding(padding: EdgeInsets.only(top: 2),child: new Text(title),)
        ],
      ),
    );
  }
}