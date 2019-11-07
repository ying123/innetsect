import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/portlets_model.dart';
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
          widget._provide.clearList();
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
  Provide<MallHomeProvide> _setupSwiperImage() {
    return Provide<MallHomeProvide>(
      builder: (BuildContext context, Widget child, MallHomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(470),
          color: Colors.white,
          child: Center(
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(420),
              color: Colors.white,
              child: provide.bannersList.length>0?Swiper(
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
                              fadeOutDuration:
                              const Duration(milliseconds: 300),
                              fadeInDuration: const Duration(milliseconds: 700),
                              fit: BoxFit.fill,
                              imageUrl: provide.bannersList[index].bannerPic,
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
                itemCount: provide.bannersList.length,
                // pagination: SwiperPagination(),
                autoplay: true,
                duration: 300,
                scrollDirection: Axis.horizontal,
              ):new Container(),
            ),
          ),
        );
      },
    );
  }

  Provide<MallHomeProvide> _setupListItemsContent() {
    return Provide<MallHomeProvide>(
      builder: (BuildContext context, Widget child, MallHomeProvide provide) {
        return Container(
          width: double.infinity,
          child: provide.portletsModelList.length>0?new Column(
            children: provide.portletsModelList.map((item){
              return _contentList(item);
            }).toList(),
          ):new Container(),
        );
      },
    );
  }

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
        widget._provide.addBannersModel(
          BannersModelList.fromJson(item.data['banners']).list
        );
        widget._provide.addListData(
          PortletsModelList.fromJson(item.data['portlets']).list
        );
      }
      print('listen data->$item');
//      _provide
    }, onError: (e) {});
  }

  _loadListData(){
    widget._provide.listData(pageNo++).doOnListen((){}).doOnCancel((){})
        .listen((item){

    },onError: (e){});
  }
}