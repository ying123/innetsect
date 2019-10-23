import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
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

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: AppBar(
        title: new Container(
          width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()-100),
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

    _tabController = new TabController(length: mallTabBarList.length, vsync: this);
    this.provides = widget.provide;
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
  Widget _tabBarView(List list){
    // 计算商品列宽度
    double itemWidth = (ScreenAdapter.getScreenWidth()-30)/2;
    return new TabBarView(
        controller: _tabController,
        children: [
          _listData(itemWidth,list),
          _listData(itemWidth,list),
//          new ListWidgetPage()
        ]
    );
  }

  /// 数据列表
  Widget _listData(double itemWidth, List list){
      return new ListWidgetPage(
//            controller: _easyController,
        onRefresh:() async{
          await Future.delayed(Duration(seconds: 2), () {
            print('onRefresh');
            setState(() {
            });
//                _easyController.resetLoadState();
          });
        },
        onLoad: () async{
          await Future.delayed(Duration(seconds: 2), () {
            print('onLoad');
            setState(() {
            });
//                _easyController.finishLoad(noMore: _count >= 20);
          });
        },
        child: <Widget>[
          // 数据内容
          SliverList(
              delegate:
              SliverChildListDelegate([
                new Container(
                  padding: EdgeInsets.all(10),
                  child: new Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: list.map((item){
                      print(item['Price'].toString());
                      return new InkWell(
                        onTap: (){
                          /// 跳转详情
                          Navigator.push(context, MaterialPageRoute(
                              builder:(context){
                                return new CommodityDetailPage();
                              },
                              settings: RouteSettings(arguments: {'id': item['id']})
                            )
                          );
                        },
                        child: new Container(
                          width: itemWidth,
                          color: Colors.grey,
                          padding: EdgeInsets.all(5),
                          child: new Column(
                            children: <Widget>[
                              // 商品图片
                              _imageWidget(item['image']),
                              // 价格 购物车图标
                              _priceAndCartWidget(item['Price'].toString()),
                              // 描述
                              _textWidget(item['describe'])
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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

  /// 商品图片
  Widget _imageWidget(String image){
    return new Stack(
      children: <Widget>[
        new Positioned(
          top:0,
          right: 0,
          child: new Container(
            padding: EdgeInsets.all(5),
            color: Colors.red,
            child: new Text("标签栏",style: TextStyle(fontSize: ScreenAdapter.size(16.0)),),
          )
        ),
        new Container(
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            )
        )
      ],
    );
  }

  /// 价格和购物车
  Widget _priceAndCartWidget(String price){
    return new Container(
      width: double.infinity,
      color: Colors.red,
      padding: EdgeInsets.all(10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 2),
                  alignment: Alignment.center,
                  child: new Text("¥ ",style: TextStyle(
                      fontSize: ScreenAdapter.size(18.0),),
                  ),
                ),
                new Container(
                    alignment: Alignment.center,
                  child: new Text(price, style: TextStyle(
                        fontSize: ScreenAdapter.size(26.0),
                        fontWeight: FontWeight.bold
                    ),
                  )
                ),

              ],
            ),
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
      padding: EdgeInsets.only(left: 6,right: 5,top: 5,bottom: 5),
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

        }
    );
  }
}