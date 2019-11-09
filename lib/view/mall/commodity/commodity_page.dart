import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_provide.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';

class CommodityPage extends PageProvideNode{
  final CommodityProvide _provide = CommodityProvide();
  CommodityPage(){
    mProviders.provide(Provider<CommodityProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return CommodityContent(_provide);
  }
}

class CommodityContent extends StatefulWidget {
  final CommodityProvide provide;

  CommodityContent(this.provide);

  @override
  _CommodityContentState createState() => new _CommodityContentState();
}

class _CommodityContentState extends State<CommodityContent> with SingleTickerProviderStateMixin{

  CommodityProvide provides;
  TabController _tabController;
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: _tabBar(),
        width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()-100),
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
                child: _tabBarView(provides.list),
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

    _tabController = new TabController(length: mallTabBarList.length, vsync: this)
    ..addListener((){
      setState(() {
        pageNo = 1;
      });
      if(_tabController.index.toDouble() == _tabController.animation.value){
        switch(_tabController.index){
          case 0:
            _loadList(pageNo: this.pageNo,types: "hotCom",isReload: true);
            break;
          case 1:
            _loadList(pageNo: this.pageNo,types: "newCom",isReload: true);
            break;
        }
      }
      print(_tabController.index);
    });
    this.provides ??= widget.provide;
    _loadList(pageNo: this.pageNo,types: "hotCom",isReload: true);
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
        labelStyle: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
        tabs: mallTabBarList.map((item){
          return new Container(
            child: new Text(item.title,maxLines: 1,),
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
//            controller: _easyController,
        onRefresh:() async{
          await Future.delayed(Duration(seconds: 2), () {
            print('onRefresh');
            this.pageNo = 1;
            _loadList(pageNo: pageNo,types: types,isReload: true);
//                _easyController.resetLoadState();
          });
        },
        onLoad: () async{
          setState(() {
            pageNo+=1;
          });
          await Future.delayed(Duration(seconds: 2), () {
            print('onLoad');

            _loadList(pageNo: pageNo ,types: types);
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
                          Navigator.push(context, MaterialPageRoute(
                              builder:(context){
                                return new CommodityDetailPage();
                              },
                              settings: RouteSettings(arguments: {'id': item.prodID})
                            )
                          );
                        },
                        child: new Container(
                          width: itemWidth,
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: new Column(
                            children: <Widget>[
                              // 商品图片
                              _imageWidget(item.prodPic),
                              // 价格 购物车图标
                              _priceAndCartWidget(item.salesPriceRange.toString()),
                              // 描述
                              _textWidget(item.prodName)
                            ],
                          ),
                        ),
                      );
                    }).toList():[],
                  ),
                )
              ])
          ),
        ],
      );
  }

  /// 搜索组件
  Widget _searchWidget(){
    return new Container(
      margin: EdgeInsets.only(left: 10,right: 10),
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

  /// 商品图片
  Widget _imageWidget(String image){
    return new Stack(
      children: <Widget>[
        new Positioned(
          top:0,
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(5),
            child: new Text("标签栏",style: TextStyle(fontSize: ScreenAdapter.size(16.0)),),
          )
        ),
        new Container(
            width: double.infinity,
            height: ScreenAdapter.height(320),
            child: Image.network(
              image,
              fit: BoxFit.fitWidth,
            )
        )
      ],
    );
  }

  /// 价格和购物车
  Widget _priceAndCartWidget(String price){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: CustomsWidget().priceTitle(price: price),
          ),
          new Container(
            width: ScreenAdapter.width(28),height: ScreenAdapter.height(28),
            child: new InkWell(
              onTap: (){
                print("购物车");
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
              },settings: RouteSettings(arguments: {'isBack': true})
          ));
        }
    );
  }



  _loadList({int pageNo=0,String types,bool isReload=false}){
    if(isReload) provides.clearList();
    provides
        .homeListData(pageNo,types)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      List<CommodityModels> list = new List();
      if(item!=null&&item.data.length>0){
        list = CommodityList.fromJson(item.data).list;
      }
      provides.setList(lists: list,isReload:isReload);
//      _provide
    }, onError: (e) {});
  }
}