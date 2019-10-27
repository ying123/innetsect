import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';

class CommodityDetailPage extends PageProvideNode{

  final CommodityDetailProvide _provide = CommodityDetailProvide();
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide();

  CommodityDetailPage(){
    mProviders.provide(Provider<CommodityDetailProvide>.value(_provide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return CommodityDetailContent(_provide,_cartProvide);
  }
  
}

class CommodityDetailContent extends StatefulWidget {
  final CommodityDetailProvide _provide;
  final CommodityAndCartProvide _cartProvide;
  CommodityDetailContent(this._provide,this._cartProvide);
  @override
  _CommodityDetailContentState createState() => new _CommodityDetailContentState();
}

class _CommodityDetailContentState extends State<CommodityDetailContent> with
    SingleTickerProviderStateMixin{

  TabController _tabController;
  ScrollController _scrollController ;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    dynamic mapData = ModalRoute.of(context).settings.arguments;
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: _topNavTabBar(),
          width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()-120)
      ),
      body: new Stack(
        children: <Widget>[
          _tabBarView(),
          new Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _bottomBar()
          )
        ],
      )
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
            width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()/6),
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
            child: WebViewWidget(url: "https://www.baidu.com",),
          )
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
              child: CustomsWidget().priceTitle(price: "1111.00"),
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
            child: CustomsWidget().subTitle(
              title: "已选", color: AppConfig.primaryColor,
            ),
          ),
          new InkWell(
            onTap: (){
//              CommodityModalBottom.showBottomModal(context);
            },
            child: new Container(
              width: ScreenAdapter.getScreenWidth()-100,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: new Text("劳斯莱斯 , M , 1件"),
            ),
          ),
          new Container(
            width: ScreenAdapter.width(60),
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
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: CustomsWidget().subTitle(
              title: "商品推荐", color: AppConfig.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  /// 底部：客服、购物车、加入购物车、立即购买
  Widget _bottomBar(){
    return new Container(
      color: Colors.white,
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
            child: InkWell(
              onTap: (){
                // 跳转到购物车
                // 如果需要返回，设置isBack为true,
                // 设置settings为传参
                // 默认为false,不返回
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return CommodityCartPage();
                  },settings: RouteSettings(arguments: {'isBack': true})
                ));
              },
              child: _iconAndTextMerge(title:"购物车",icon: "assets/images/mall/cart_icon.png"),
            )
          ),
          new Padding(padding: EdgeInsets.only(left: 17),
            child: new InkWell(
              onTap: (){
                print("点击购物车");
                CommodityModalBottom.showBottomModal(context,widget._cartProvide);
              },
              child: new Container(
                width: ScreenAdapter.width(230),
                height: ScreenAdapter.height(90),
                color: Colors.black,
                alignment: Alignment.center,
                child: new Text("加入购物车",style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
              )
            ),
          ),
          new Padding(padding: EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: (){
                // 跳转订单详情
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context){
                      return new OrderDetailPage();
                    })
                );
              },
              child: new Container(
                width: ScreenAdapter.width(230),
                height: ScreenAdapter.height(90),
                color: AppConfig.primaryColor,
                alignment: Alignment.center,
                child: new Text("立即购买",style: TextStyle(color: AppConfig.fontBackColor,
                    fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
              ),
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
          new Text(title)
        ],
      ),
    );
  }
}