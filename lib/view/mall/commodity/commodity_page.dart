import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_badges_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/view/mall/search/search_page.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/logistics/logistics_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_provide.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';

class CommodityPage extends PageProvideNode{
  final CommodityProvide _provide = CommodityProvide();
  final LogisticsProvide _logisticsProvide = LogisticsProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  CommodityPage(){
    mProviders.provide(Provider<CommodityProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<LogisticsProvide>.value(_logisticsProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return CommodityContent(_provide,_detailProvide,_logisticsProvide,_cartProvide);
  }
}

class CommodityContent extends StatefulWidget {
  final CommodityProvide provide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final LogisticsProvide _logisticsProvide;
  CommodityContent(this.provide,this._detailProvide,this._logisticsProvide,this._cartProvide);

  @override
  _CommodityContentState createState() => new _CommodityContentState();
}

class _CommodityContentState extends State<CommodityContent> with SingleTickerProviderStateMixin{

  CommodityProvide provides;
  CommodityDetailProvide _detailProvide;
  LogisticsProvide _logisticsProvide;
  CommodityAndCartProvide _cartProvide;
  TabController _tabController;
  EasyRefreshController _easyRefreshController;
  List<CommodityModels> list=[];
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: _tabBar(),
        width: ScreenAdapter.getScreenWidth()-100,
        centerTitle: false,
        leading: false
      ),
      body: Provide<CommodityProvide>(
        builder: (BuildContext context,Widget widget,CommodityProvide provide){
          return new Stack(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(
                    top: ScreenAdapter.height(88.0)
                ),
                child: _tabBarView(list),
              ),
              //307pt*20pt
              new Positioned(
                  top: 5,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(20*ScreenAdapter.getPixelRatio()),
                  child: CustomsWidget().searchWidget(
                      onTap: (){
                        //搜索页面
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return SearchPage();
                            }
                        ));
                      }
                  )
              )
            ],
          );
        },
      ),
      floatingActionButton: new Builder(builder: (context){
        return _cartBtnWidget();
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.provides ??= widget.provide;
    this._detailProvide ??= widget._detailProvide;
    _logisticsProvide??=widget._logisticsProvide;
    _cartProvide ??= widget._cartProvide;
    _logisticsProvide.backPage = "/mallPage";
    _easyRefreshController = EasyRefreshController();

    _tabController = new TabController(length: mallTabBarList.length, vsync: this)
    ..addListener((){
      if(_tabController.index.toDouble() == _tabController.animation.value){
        switch(_tabController.index){
          case 0:
            setState(() {
              pageNo = 1;
              list=[];
            });
            _loadList(types: "hotCom");
            break;
          case 1:
            setState(() {
              pageNo = 1;
              list=[];
            });
            _loadList(types: "newCom");
            break;
        }
      }
      print(_tabController.index);
    });
    _loadList(types: "hotCom");
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
        isScrollable: true,
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: new TextStyle(fontSize: 14.0),
        labelColor: Colors.black,
        labelStyle: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
        tabs: mallTabBarList.map((item){
          return new FractionallySizedBox(
            child: new Text(item.title,maxLines: 1,softWrap: false,),
          );
        }).toList()
    );
  }

  /// tabbarview视图组件
  Widget _tabBarView(List<CommodityModels> list){
    // 计算商品列宽度
    double itemWidth = (ScreenAdapter.getScreenWidth()-30)/2;
    return new TabBarView(
        controller: _tabController,
        children: [
          _listData(itemWidth,list,"hotCom"),
          _listData(itemWidth,list,"newCom"),
//          new ListWidgetPage()
        ]
    );
  }

  /// 数据列表
  Widget _listData(double itemWidth, List<CommodityModels> list,String types){
      return new ListWidgetPage(
        controller: _easyRefreshController,
        onRefresh:() async{
          await Future.delayed(Duration.zero, () {
            print('onRefresh');
            setState(() {
              this.pageNo = 1;
              this.list=[];
            });
            _loadList(types: types);
//                _easyController.resetLoadState();
          });
        },
        onLoad: () async{
          await Future.delayed(Duration.zero, () {
            _loadList(types: types);
//                _easyController.finishLoad(noMore: _count >= 20);
          });
        },
        child: <Widget>[
          // 数据内容
          SliverList(
              delegate:
              SliverChildListDelegate([
                new Container(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: new Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: list!=null? list.map((item){
                      print(item);
                      return new InkWell(
                        onTap: (){
                          /// 跳转详情
                          /// 加载详情
                          _loadDetail(item.prodID,item.shopID);

                        },
                        child: new Container(
                          width: itemWidth,
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: new Column(
                            children: <Widget>[
                              // 商品图片
                              _imageWidget(item.prodPic,item.badges),
                              // 价格 购物车图标
                              _priceAndCartWidget(item.salesPriceRange.toString(),item.originalPrice.toString(),item.prodID,item.shopID),
                              // 描述
                              _textWidget(item.prodName)
                            ],
                          ),
                        ),
                      );
                    }).toList():CustomsWidget().noDataWidget(),
                  ),
                )
              ])
          ),
        ],
      );
  }

  /// 商品图片
  Widget _imageWidget(String image,List<CommodityBadgesModel> badges){
    return Stack(
      children: <Widget>[
        new Container(
            width: double.infinity,
            height: ScreenAdapter.height(320),
            child:image!=null? CachedNetworkImage(
              imageUrl:image+ConstConfig.BANNER_FOUR_SIZE,
              fit: BoxFit.fitWidth,
            ):Image.asset("assets/images/default/default_img.png",fit: BoxFit.fitWidth,)
        ),
        Positioned(
          top: 0,
          right: 0,
          child: badges!=null&&badges.length>0?
              Row(
                children: badges.map((item){
                  return Container(
                    width: ScreenAdapter.width(80),
                    height: ScreenAdapter.height(40),
                    color: AppConfig.blueBtnColor,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 5),
                    child: Text(item.name,style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(24)
                    ),),
                  );
                }).toList(),
              ):Container(width: 0,height: 0,),
        )
      ],
    );
  }

  /// 价格和购物车
  Widget _priceAndCartWidget(String price,String originalPrice,int prodID,int shopID){
    Widget widgets = Container();
    if(originalPrice!='null'){
      if(double.parse(price)<double.parse(originalPrice)){
        widgets = Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomsWidget().priceTitle(price: originalPrice,decoration: TextDecoration.lineThrough,fontSize: ScreenAdapter.size(20),
              fontWeight: FontWeight.w400
          ),
        );
      }
    }
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomsWidget().priceTitle(price: price),
                widgets
              ],
            )
          ),
          new Container(
            width: ScreenAdapter.width(28),height: ScreenAdapter.height(28),
            child: new InkWell(
              onTap: (){
                print("购物车");
                _loadDetail(prodID,shopID);
                CommodityModalBottom.showBottomModal(context:context);
              },
              child: new Image.asset("assets/images/mall/shop_bucket.png",
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 描述
  Widget _textWidget(String text){ 
    return new Container(
      padding: EdgeInsets.only(left: 6,right: 5,bottom: 5),
      height: ScreenAdapter.height(80),
      alignment: Alignment.topLeft,
      child: new Text(text,softWrap: true,maxLines: 2,textAlign: TextAlign.left,
        style: TextStyle(fontSize: ScreenAdapter.size(26)),
      ),
    );
  }

  /// 购物车悬浮按钮
  Widget _cartBtnWidget(){
    return FloatingActionButton(
        child: new Image.asset("assets/images/mall/cart_icon.png",
          width: 30,
          fit:BoxFit.fitWidth ,
        ),
        elevation: 7.0,
        onPressed:(){
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return CommodityCartPage();
              },settings: RouteSettings(arguments: {'isBack': true,'page':'mall'})
          ));
        }
    );
  }



  _loadList({String types}){
    provides
        .homeListData(pageNo++,types)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      setState(() {
        list..addAll(CommodityList.fromJson(item.data).list);
      });
//      List<CommodityModels> list = new List();
//      if(item!=null&&item.data.length>0){
//        list = CommodityList.fromJson(item.data).list;
//      }
//      provides.setList(lists: list,isReload:isReload);
//      _provide
    }, onError: (e) {});
  }

  _loadDetail(int prodID,int shopID){
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
    Loading.ctx=context;
    Loading.show();
    /// 加载详情数据
    _detailProvide.detailData(types: shopID,prodId:prodID,context: context )
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
//          Loading.remove();
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        _detailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
        _detailProvide.setInitData();
        _cartProvide.setInitCount();
        _detailProvide.isBuy = false;
        _cartProvide.setMode(mode: "multiple");
        Loading.remove();
        Navigator.push(context, MaterialPageRoute(
            builder:(context){
              return new CommodityDetailPage();
            }
        )
        );
      }
//      _provide
    }, onError: (e) {});
  }
}