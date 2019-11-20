import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/portlets_model.dart';
import 'package:innetsect/data/mall/promotion_model.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/home/mall_home_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MallHomePage extends PageProvideNode {
  final MallHomeProvide _provide = MallHomeProvide();
  MallHomePage(){
    mProviders.provide(Provider<MallHomeProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return MallHomeContent(_provide);
  }

}

class MallHomeContent extends StatefulWidget {

  final MallHomeProvide _provide;

  MallHomeContent(this._provide);

  @override
  _MallHomeContentState createState() => new _MallHomeContentState();
}

class _MallHomeContentState extends State<MallHomeContent> {

  // 控制器
  EasyRefreshController _controller;
  // 分页
  int pageNo = 1;
  List<BannersModel> _bannersList=[];

  List<PortletsModel> _portletsModelList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text(
          '商城',
          style: TextStyle(
              fontSize: ScreenAdapter.size(40),
              fontWeight: FontWeight.w600,
              color: AppConfig.fontPrimaryColor),
        ),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '去展会',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                  color: AppConfig.fontPrimaryColor,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/appNavigationBarPage');
            },
          ),
          SizedBox(
            width: ScreenAdapter.width(20),
          )
        ],
      ),
      body: new ListWidgetPage(
        controller: _controller,
        onRefresh: () async{
          pageNo = 1;
          _clearList();
          await _loadBannerData();
        },
        onLoad: () async{
          await _loadListData();
        },
        child: <Widget>[
            // 数据内容
            SliverList(
              delegate:
                SliverChildListDelegate([
                  _setupSwiperImage(),
                  _setupListItemsContent()
                ])
            )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new EasyRefreshController();
    // 加载首页数据
    _loadBannerData();
  }

  ///轮播图
  Widget _setupSwiperImage() {
    return Container(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(470),
      color: Colors.white,
      child: Center(
        child: Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(420),
          color: Colors.white,
          child: _bannersList.length>0?Swiper(
            index: 0,
            loop: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('第$index 页被点击');
                },
                child: ClipPath(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(420),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: _bannersList[index].bannerPic,
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: _bannersList.length,
            // pagination: SwiperPagination(),
            autoplay: true,
            duration: 300,
            scrollDirection: Axis.horizontal,
          ):new Container(),
        ),
      ),
    );
  }

  /// 商品集合
  Widget _setupListItemsContent() {
    Widget widget;
    if(_portletsModelList.length>0){
      widget = Container(
        width: double.infinity,
        child: Column(
          children: _portletsModelList.map((item)=>_portletContentList(item)).toList(),
        ),
      );
    }else{
      widget = Container();
    }
    return widget;
  }

  /// 商品集合
  Widget _portletContentList(PortletsModel model){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headerContent(model.promotion)
        ],
      ),
    );
  }

  /// 商品集合--头部样式
  Widget _headerContent(PromotionModel model){
    return new IntrinsicHeight(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.getScreenWidth()/4,
                height: ScreenAdapter.height(20),
                color: Colors.red,
                child: new Text(model.promotionName),
              )
            ],
          )
        ],
      ),
    );
  }

  ///TODO 废弃
  Widget _contentList(PortletsModel model){
    Widget widget;
    switch(model.contents.length) {
      case 1:
        widget = new Container(
          width: double.infinity,
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new Image.network(model.contents[0].mediaFiles,
                width: double.infinity,
                height:ScreenAdapter.height(420),fit:BoxFit.fitWidth,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 20),
                    child: new Container(
                      color: Colors.black,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      child: new Text(model.contents[0].tags,style: TextStyle(color:Colors.white),),
                    ),
                  )
                ],
              )
            ],
          ),
        );
        break;
      case 2:
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: model.contents.map((res){
            return new Container(
              width: ScreenAdapter.getScreenWidth()/2-20 ,
              height: ScreenAdapter.height(480),
              color: Colors.white,
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: new Column(
                children: <Widget>[
                  new Image.network(res.poster,fit: BoxFit.fitHeight,
                  height: ScreenAdapter.height(360),),
                  new Text(res.title,maxLines: 1,style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 20),
                        child: new Container(
                          color: Colors.black,
                          margin: EdgeInsets.only(left: 10,top: 15),
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: new Text(res.tags,style: TextStyle(color:Colors.white,
                              fontSize: ScreenAdapter.size(18)),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        );
        break;
      default:
        widget = new Container();
        break;
    }
    return widget;
  }

  _loadBannerData(){
    widget._provide.bannerData()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      if(item.data!=null){
        setState(() {
          _bannersList=BannersModelList.fromJson(item.data['banners']).list;
          _portletsModelList..addAll( PortletsModelList.fromJson(item.data['portlets']).list);
        });
      }
      print('listen data->$item');
//      _provide
    }, onError: (e) {});
  }

  _loadListData(){
    widget._provide.listData(pageNo++).doOnListen((){}).doOnCancel((){})
        .listen((item){
//        setState(() {
//          _portletsModelList..addAll( PortletsModelList.fromJson(item.data).list);
//        });
    },onError: (e){});
  }

  _clearList(){
    setState(() {
      _bannersList.clear();
      _portletsModelList.clear();
    });
  }
}