import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';

class CommodityDetailPage extends PageProvideNode{

  final CommodityDetailProvide _provide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;

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

//  TabController _tabController;
  ScrollController _scrollController ;
  CommodityDetailProvide _provide;
  CommodityAndCartProvide _cartProvide;
  // webview
  String html;

  int pageNo = 1;
  /// 推荐商品
//  List<List<CommodityModels>> recommedList = new List();

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: Container(),
          width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()-120)
      ),
      body: _contentWidget(),
      bottomSheet: _bottomBar(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _provide ??= widget._provide;
    _cartProvide ??= widget._cartProvide;

//    _tabController = new TabController(length: detailTabBarList.length, vsync: this);
    _scrollController = new ScrollController();

//    _scrollController.addListener((){
//      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
//        _tabController.index=1;
//      }
//    });

//    _loadData();
    _loadHtml();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _tabController.dispose();
  }

  ///TODO 商品顶部导航（暂时隐藏)
  /**Widget _topNavTabBar(){
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
  }*/

  ///TODO tabBarView视图组件（暂时隐藏)
  /**Widget _tabBarView(){
    return new TabBarView(
        controller: _tabController,
        children: [
          _contentWidget(),
          new Container(
            child: WebViewWidget(url: "https://www.baidu.com",),
          )
        ]
    );
  }*/

  /// 商品详情内容区域
  Widget _contentWidget(){
    return new Container(
      color: AppConfig.backGroundColor,
      child: new ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            new Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(563),
              color: Colors.white,
              child: _swiperWidget(),
            ),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: _comTitle(),
            ),
            new Padding(padding: EdgeInsets.only(top: 10),
              child: _selCol(),
            ),
//            new Padding(padding: EdgeInsets.only(top: 10),
//              child: _recommendWidget(),
//            ),
//            new Padding(padding: EdgeInsets.only(top: 10),
//              child: new Container(
//                color: Colors.white,
//                padding: EdgeInsets.all(10),
//                margin: EdgeInsets.only(bottom: 10),
//                alignment: Alignment.center,
//                child: new Text("上拉显示商品详情",style: TextStyle(
//                    fontSize: ScreenAdapter.size(26),
//                    fontWeight: FontWeight.w600),
//                ),
//              )
//            ),
            html!=null?new Container(
              child: Html(
                data: html,
              ),
            ):new Container(),
            SizedBox(width: double.infinity,height: ScreenAdapter.height(80),)
          ],
        ),
    );
  }

  /// _swiperWidget
  Provide<CommodityDetailProvide> _swiperWidget(){
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context, Widget widget,CommodityDetailProvide provide){
        CommoditySkusModel skuModel = provide.skusModel;
        return new Swiper(
          itemBuilder: (BuildContext context,int index){
            return skuModel!=null?Image.network(skuModel.pics[index].skuPicUrl+ConstConfig.BANNER_SIZE):new Container();
          },
          loop: true,
          itemCount: skuModel!=null?skuModel.pics.length:1,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white70,              // 其他点的颜色
                  activeColor: AppConfig.blueBtnColor,      // 当前点的颜色
                  space: 2,                           // 点与点之间的距离
                  activeSize: 5,                      // 当前点的大小
                  size: 5
              )
          ),
        );
      },
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
          _comTitleProdName(),
          new Padding(padding: EdgeInsets.only(top: 10),
            child: new Container(
              child: _comTitleSalesPrice()
            ),
          )
        ],
      ),
    );
  }

  /// 标题 prodName
  Provide<CommodityDetailProvide> _comTitleProdName() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,
            CommodityDetailProvide provide) {
          CommodityModels models = provide.commodityModels;
          return new Text(models!=null?models.prodName:"",style: TextStyle(fontSize: ScreenAdapter.size(38),
              fontWeight: FontWeight.w800
          ),);
        }
    );
  }
  /// 标题价格
  Provide<CommodityDetailProvide> _comTitleSalesPrice() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,
            CommodityDetailProvide provide) {
          CommodityModels models = provide.commodityModels;
          return CustomsWidget().priceTitle(price: models!=null?models.salesPrice.toString():"");
        }
    );
  }

  /// 已选栏目
  Widget _selCol(){
    return new InkWell(
      onTap: (){
        /// 弹出颜色，尺码选择
        _provide.setInitData();
        _cartProvide.setInitCount();
        _provide.isBuy = false;
        CommodityModalBottom.showBottomModal(context:context);
      },
      child: new Container(
        height: ScreenAdapter.height(110),
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: new Row(
          children: <Widget>[
            new Container(
              child: CustomsWidget().subTitle(
                title: "已选", color: AppConfig.primaryColor,
              ),
            ),
            new Container(
              width: ScreenAdapter.getScreenWidth()-150,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: _selColSkuName(),
            ),
            new Expanded(
              flex:1,
              child: new Icon(Icons.more_horiz),
            )
          ],
        ),
      ),
    );
  }

  /// 已选skuName
  Provide<CommodityDetailProvide> _selColSkuName() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,CommodityDetailProvide provide) {
          CommoditySkusModel model = provide.skusModel;
          List list;
          if(model!=null){
            list = CommonUtil.skuNameSplit(model.skuName);
          }
          return new Text(list!=null?list[1]:model!=null?model.skuName:"");
        }
    );
  }
  ///TODO 推荐（暂时隐藏)
  /**Widget _recommendWidget(){
    double childHeight = ScreenAdapter.getScreenHeight()/1.5;
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(1100),
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: CustomsWidget().subTitle(
              title: "商品推荐", color: AppConfig.primaryColor,
            ),
          ),
          new Container(
            width: double.infinity,
            height: childHeight,
            color: Colors.white,
            child: new Swiper(
              itemCount: recommedList.length>0?recommedList.length:1,
              index: 0,
              loop: false,
              scrollDirection: Axis.horizontal,
              pagination: new SwiperPagination(
                margin: EdgeInsets.only(top: 20),
                builder: DotSwiperPaginationBuilder(
                  activeColor: AppConfig.primaryColor,
                  color: AppConfig.assistLineColor
                )
              ),
              itemBuilder: (BuildContext context,int index) {
                return new Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: recommedList.length>0 ?
                      new Wrap(
                        spacing: 10,
                        runSpacing: 5,
                        children: recommedList[index].map((item){
                          return new Container(
                            width: ScreenAdapter.getScreenWidth()/2-10,
                            height: childHeight/2-15,
                            alignment: Alignment.topCenter,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.network(item.prodPic,height: ScreenAdapter.height(280),),
                                new Container(
                                  width: ScreenAdapter.getScreenWidth()/2-10,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 10,bottom: 5),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new CustomsWidget().priceTitle(price: item.defSalesPrice.toString())
                                    ],
                                  )
                                ),
                                new Container(
                                  width: ScreenAdapter.getScreenWidth()/2-10,
                                  alignment: Alignment.center,
                                  child: new Text(item.prodName,style: TextStyle(fontSize: ScreenAdapter.size(24)),
                                    maxLines: 2,),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                      :new Container(),
                );
              },
            ),
          )
        ],
      ),
    );
  }*/

  /// 底部：客服、购物车、加入购物车、立即购买
  Widget _bottomBar(BuildContext context){
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.height(100),
      color: Colors.white,
      padding: EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 12),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _iconAndTextMerge(title:"客服",icon: "assets/images/mall/service_p_icon.png"),
          ),
          Expanded(
            flex: 1,
            child: new Padding(padding: EdgeInsets.only(left: 10),
                child: _iconAndTextMerge(title:"购物车",icon: "assets/images/mall/cart_icon.png",
                onTap: (){
                  // 跳转到购物车
                  // 如果需要返回，设置isBack为true,
                  // 设置settings为传参
                  // 默认为false,不返回
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return CommodityCartPage();
                      },settings: RouteSettings(arguments: {'isBack': true,'page':'mall'})
                  ));
                }),
            ),
          ),
          Expanded(
            flex: 3,
            child: new Padding(padding: EdgeInsets.only(left: 10),
              child: new InkWell(
                  onTap: (){
                    _provide.setInitData();
                    _cartProvide.setInitCount();
                    _provide.isBuy = false;
                    CommodityModalBottom.showBottomModal(context:context);
                  },
                  child: new Container(
                    width: ScreenAdapter.width(230),
                    height: ScreenAdapter.height(80),
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: new Text("加入购物车",style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
                  )
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: new Padding(padding: EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: (){
                  _provide.setInitData();
                  _cartProvide.setInitCount();
                  _provide.isBuy = true;
                  // 存储当前商品信息
                  CommodityModalBottom.showBottomModal(context:context);
                },
                child: new Container(
                  width: ScreenAdapter.width(230),
                  height: ScreenAdapter.height(80),
                  color: AppConfig.blueBtnColor,
                  alignment: Alignment.center,
                  child: new Text("立即购买",style: TextStyle(color: AppConfig.whiteBtnColor,
                      fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)),),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  /// 图片和文字结合，垂直布局
  Widget _iconAndTextMerge({String title,String icon,Function() onTap}){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(icon,width: ScreenAdapter.width(32),height: ScreenAdapter.height(32),fit: BoxFit.fitWidth,),
            new Text(title,style: TextStyle(fontSize: ScreenAdapter.size(18)),)
          ],
        ),
      ),
    );
  }

  /// 加载数据
//  _loadData() {
//     _provide.detailData()
//        .doOnListen(() {
//      print('doOnListen');
//    })
//        .doOnCancel(() {})
//        .listen((item) {
//      ///加载数据
//      print('listen data->$item');
//      _provide.setCommodityModels(CommodityModels.fromJson(item.data));
////      _provide
//    }, onError: (e) {});
//  }

  /// 加载webview
  _loadHtml() async{
    await _provide.getDetailHtml().then((item){
      print(item);
      if(item.data!=null){
        setState(() {
          html = item.data;
        });
      }
    });
  }

  ///TODO 商品推荐(暂时隐藏)
  /**_loadRemData(int pageNo,int types,int prodID){
    _provide.recommendedListData(pageNo, types, prodID).doOnListen((){}).doOnCancel((){})
        .listen((item){
          if(item.data!=null){
            List<CommodityModels> list = CommodityList.fromJson(item.data).list;
            List<CommodityModels> lists = [];
            list.asMap().keys.forEach((keys){
              if((keys+1)%4==0){
                lists.add(list[keys]);
                setState(() {
                  recommedList.add(lists);
                });
                lists=[];
              }else{
                lists.add(list[keys]);
              }
            });
          }
    },onError: (e){});
  }*/
}