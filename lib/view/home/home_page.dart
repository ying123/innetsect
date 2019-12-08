import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/home_portlets_model.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/promotion_model.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/activity/activity_detail_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/mall/information/infor_web_page.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view/mall/web_view.dart';
import 'package:innetsect/view/my/vip_card/vip_card_page.dart';
import 'package:innetsect/view/shopping/high_commodity_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/information/information_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends PageProvideNode {
  final HomeProvide _provide = HomeProvide();
  final LoginProvide _loginProvide = LoginProvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final SearchProvide _searchProvide = SearchProvide();
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  final InformationProvide _informationProvide = InformationProvide.instance;
  HomePage() {
    mProviders.provide(Provider<HomeProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<InformationProvide>.value(_informationProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return HomeContentPage(_provide,_loginProvide,_detailProvide,_cartProvide,
        _searchProvide,_commodityListProvide,_informationProvide);
  }
}

class HomeContentPage extends StatefulWidget {
  final HomeProvide _provide;
  final LoginProvide _loginProvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final SearchProvide _searchProvide ;
  final CommodityListProvide _commodityListProvide;
  final InformationProvide _informationProvide;
  HomeContentPage(this._provide,this._loginProvide,
      this._detailProvide,this._cartProvide,
      this._searchProvide,this._commodityListProvide,this._informationProvide);
  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage>
    with TickerProviderStateMixin {
  HomeProvide _provide;
  LoginProvide _loginProvide;
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide _cartProvide;

  ///控制器
  EasyRefreshController _controller;

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  ///分页
  int pageNo = 1;
  String _poster;
  bool _isPlay=false;

  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
    _loginProvide ??= widget._loginProvide;
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;
    _controller = EasyRefreshController();

    //加载首页数据
    _loadBannerData();
    
    
  }

  _loadBannerData() {
    _provide.bannerData().doOnListen(() {}).doOnCancel(() {}).listen((item) {
      print('bannerData=====>${item.data}');
      if (item.data != null) {
        print('exhibitionID===>${item.data['exhibitionID']}');
        _provide.portalID = item.data['portalID'];
        _provide.portalName = item.data['portalName'];
        _provide.portalCover = item.data['portalCover'];
        _provide.exhibitionID = item.data['exhibitionID'];
        _provide.layout = item.data['layout'];
        _provide.createdDate = item.data['createdDate'];
        _provide.createdBy = item.data['createdBy'];
        _provide.lastModified = item.data['lastModified'];
        _provide.lastModifiedBy = item.data['lastModifiedBy'];

        _provide.addBanners(
            BannersModelList.fromJson(item.data['banners']).list);
        setState(() {
          _provide.addPortlets(
              HomePortletsModelList.fromJson(item.data['portlets']).list);
        });
        if(_provide.portletsModelList.length>0&&
            _provide.portletsModelList[0].contents!=null){
          String videoUrl = _provide.portletsModelList[0].contents[0].mediaFiles;
          String poster = _provide.portletsModelList[0].contents[0].poster;
          _videoPlayerController = VideoPlayerController.network(videoUrl);
          _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              aspectRatio: 9.5 / 5,
              autoPlay: false,
              autoInitialize: true,
              looping: true,
              placeholder:Image.network(poster)
          );
          setState(() {
            _poster = poster;
          });
        }

        _provide.exhibitions(_provide.exhibitionID).doOnListen((){

        }).doOnError((e, siack){

        }).listen((item){
          print('exhibitions=====>${item.data}');
          if (item != null) {
           _provide.addHalls(HallsModelList.fromJson(item.data['halls']).list);
           _provide.shopID = item.data['shopID'];
           _provide.locOverview = item.data['locOverview'];
          }
        });
      }
    });
  }

  _loadListData(){
    _provide.listData(pageNo++).doOnListen((){}).doOnCancel((){}).listen((item){
   // _provide.addPortlets(HomePortletsModelList.fromJson(item.data).list);
    },onError: (e){});
  }

  /// 扫码
  _loadQrCode(String result){
//    Loading.ctx = context;
//    Loading.show();
    _loginProvide.getUserInfo(context:context).doOnListen((){}).doOnCancel((){}).listen((userItem){
      if(userItem!=null&&userItem.data!=null){
        _loginProvide.setUserInfoModel(UserInfoModel.fromJson(userItem.data));
        // 解析二维码
        if(result.indexOf("&&")>-1){
          List list = result.split("&&");
          if(list.length>0){
            var json = {
              "qrType":list[0],
              "qrCode":list[1]
            };
//            CustomsWidget().customShowDialog(context: context,
//                title: "解析结果",
//                content: json.toString());
            // 扫码
            _provide.qrCodeWhisk(json).doOnListen((){}).doOnCancel((){}).listen((item){
//          Loading.remove();
              if(item!=null&&item.data!=null){
                if(list[0]=="EXHIBIT_PRODUCT"){
                  // 商品详情
                  CommodityModels models = CommodityModels.fromJson(item.data);
                  _detailProvide.clearCommodityModels();
                  _detailProvide.prodId = models.prodID;
                  /// 加载详情数据
                  _detailProvide.setCommodityModels(models);
                  _detailProvide.setInitData();
                  _cartProvide.setInitCount();
                  _detailProvide.isBuy = false;

                  if(models.panicBuying&&models.skuName!=null){
                    // 跳转抢购商品
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return HighCommodityPage();
                        }
                    ));
                  }else if(!models.panicBuying){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return CommodityDetailPage(pages: ConstConfig.EXHIBIT_PRODUCT,);
                        }
                    ));
                  }else if(models.promptingMessage.toString().isNotEmpty){
                    CustomsWidget().showToast(title: models.promptingMessage.toString());
                  }
                }else{
                  // vip贵宾卡
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return VIPCardPage();
                      }
                  ));
                }
              }
            },onError: (e){});
          }
        }else{
          CustomsWidget().showToast(title: "二维码识别失败，请重新扫描");
        }


      }
    },onError: (e){
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    print('进入主页');
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            '展会',
            style: TextStyle(
                //  fontSize: ScreenAdapter.size(40),
                // fontWeight: FontWeight.w600,
                color: AppConfig.fontPrimaryColor),
          ),
          centerTitle: true,
          leading: Container(),
          actions: <Widget>[
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '去商城',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: AppConfig.fontPrimaryColor,
                  ),
                ),
              ),
              onTap: () {
                print('进入商城被点击');
                if(_isPlay){
                  _chewieController.pause();
                  _chewieController.dispose();
                }
                Navigator.pushNamed(context, '/mallPage');
              },
            ),
            SizedBox(
              width: ScreenAdapter.width(20),
            )
          ],
        ),
        body: ListWidgetPage(
          controller: _controller,
          onRefresh: () async {
            pageNo = 1;
            print('onRefresh');
            _provide.clearList();
            await _loadBannerData();
          },
          onLoad: () async {
            await _loadListData();
          },
          child: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                _setupSwiperImage(),
                _setupCenter(),
                _setupListItemsContent(),
                _setupListItemsContents()
              ]),
            )
          ],
        ));
  }

  Provide<HomeProvide> _setupSwiperImage() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(390),
          child: provide.bannersList.length > 0
              ? Swiper(
            loop: false,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('$index');
                        /// 跳转商品详情
                        if(provide.bannersList[index].redirectType==ConstConfig.PRODUCT_DETAIL){
                          List list = provide.bannersList[index].redirectParam.split(":");
                          _commodityDetail(types:int.parse(list[0]) ,prodID: int.parse(list[1]));
                        }else if(provide.bannersList[index].redirectType==ConstConfig.PROMOTION){
                          /// 跳转集合搜索列表
                          _searchRequest(provide.bannersList[index].redirectParam);
                        }else if(provide.bannersList[index].redirectType==ConstConfig.CONTENT_DETAIL){
                          /// 跳转资讯详情
                          widget._informationProvide.contentID =int.parse(provide.bannersList[index].redirectParam) ;
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return new InforWebPage();
                              }
                          ));
                        }else if(provide.bannersList[index].redirectType==ConstConfig.URL){
                          /// 跳转URL
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return new WebView(url: provide.bannersList[index].redirectParam,);
                              }
                          ));
                        }else if(provide.bannersList[index].redirectType == ConstConfig.ACTIVITY){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return ActivityDetailPage(activityID: int.parse(provide.bannersList[index].redirectParam),);
                              }
                          ));
                        }
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: provide.bannersList[index].bannerPic,
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error);
                        },
                      ),
                    );
                  },
                  itemCount: provide.bannersList.length,
                  scrollDirection: Axis.horizontal,
                  //   pagination: SwiperPagination(),
                )
              : Container(),
        );
      },
    );
  }

  Provide<HomeProvide> _setupCenter() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(270),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/showTickets',arguments: {"shopID":provide.shopID});
                },
                child: Image.asset(
                  'assets/images/showhome/购买门票.png',
                  width: ScreenAdapter.width(131),
                  height: ScreenAdapter.height(115),
                ),
              ),
              InkWell(
                onTap: (){
                  if (AppConfig.userTools.getUserToken() == '') {
                    Navigator.pushNamed(context, '/loginPage');
                  }else{
                    Navigator.pushNamed(context, '/bindingSignIn');
                  }

                },
                child: Image.asset(
                  'assets/images/showhome/签到绑定.png',
                  width: ScreenAdapter.width(131),
                  height: ScreenAdapter.height(115),
                ),
              ),
              InkWell(
                onTap: ()async{
                  // 必须登录才能扫码
                  try {
                    //扫码结果
                    String barcode = await scanner.scan();
                    print('扫码结果=>$barcode');
//                    CustomsWidget().customShowDialog(context: context,
//                    title: "扫码结果",
//                    content: barcode.toString());
                    _loadQrCode(barcode);

                  }on PlatformException catch(e){
                    if (e.code == scanner.CameraAccessDenied) {
                      //未授于App相机权限
                      print('未授于App相机权限');
                    }else
                      //扫码错误
                      CustomsWidget().showToast(title: "二维码识别失败，请重新扫描");
                      print('扫码错误:$e');
                    }

                },
                child: Image.asset(
                  'assets/images/showhome/扫码购物.png',
                  width: ScreenAdapter.width(131),
                  height: ScreenAdapter.height(115),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/venuesMapPage',arguments: {
                    'halls':provide.hallsModelList,
                    'showId':provide.shopID,
                    'locOverview':provide.locOverview
                  });
                },
                child: Image.asset(
                  'assets/images/showhome/场馆地图.png',
                  width: ScreenAdapter.width(131),
                  height: ScreenAdapter.height(115),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<HomeProvide> _setupListItemsContent() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        return ListView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          primary: false,
          itemCount: provide.portletsModelList.length,
          itemBuilder: (BuildContext context, int index) {
            if(provide.portletsModelList[index].contents!=null){
              return InkWell(
                onTap: () {
                  print(index);
                  setState(() {
                    _isPlay = true;
                    _chewieController.play();
                  });
//                  Navigator.pushNamed(context, '/homePortletsDetailsPage',arguments: {"contentID":provide.portletsModelList[index].contents[0].contentID});
                },
                child: Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(620),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(435),
                        child: provide.portletsModelList[index]
                            .contents[0]
                            .mediaFiles.indexOf(".mp4")>-1
                            ? _isPlay?Chewie(
                          controller: _chewieController,
                        ):Stack(
                          children: <Widget>[
                            SizedBox.expand(
                              child: Image.network(_poster,fit: BoxFit.fitWidth,),
                            ),
                            Positioned(
                              left: ScreenAdapter.width(750)/2.3,
                              top: ScreenAdapter.height(435)/2.3,
                              child: Icon(Icons.play_circle_outline,size: 48,),
                            )
                          ],
                        )
                            : Image.network(
                          provide.portletsModelList[index].contents[0].mediaFiles,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else{
              return Container(height: 0.0,width: 0,);
            }
          },
        );
      },
    );
  }

  /// 商品详情
  _commodityDetail({int types,int prodID}){
    /// 跳转商品详情
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
    /// 加载详情数据
    _detailProvide.detailData(types: types,prodId:prodID,context: context)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      _detailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
      _detailProvide.setInitData();
      _cartProvide.setInitCount();
      _detailProvide.isBuy = false;
      Navigator.push(context, MaterialPageRoute(
          builder:(context){
            return new CommodityDetailPage(pages: ConstConfig.EXHIBIT_PRODUCT);
          }
      )
      );
      //      _provide
    }, onError: (e) {});
  }


  /// 搜索请求
  void _searchRequest(String code){
    // 清除原数据
    widget._commodityListProvide.clearList();
    widget._commodityListProvide.requestUrl = "/api/promotion/promotions/$code/products?";

    widget._searchProvide.onSearch(widget._commodityListProvide.requestUrl+'pageNo=1&sort=&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        widget._searchProvide.searchValue = items.data['promotionName'];
        widget._commodityListProvide.addList(CommodityList.fromJson(items.data['products']).list);
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return SearchScreenPage(pages: ConstConfig.EXHIBIT_PRODUCT);
            }
        ));
      }

    }, onError: (e) {});
  }

  /// 商品集合
  Widget _setupListItemsContents() {
    Widget widget;
    if(_provide.portletsModelList.length>0){
      widget = Container(
        width: ScreenAdapter.width(750),
        child: Column(
          children: _provide.portletsModelList.map((item)=>_portletContentList(item)).toList(),
        ),
      );
    }else{
      widget = Container(height: 0,width: 0,);
    }
    return widget;
  }

  /// 商品集合
  Widget _portletContentList(HomePortletsModel model){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10,right: 10),
      child: model!=null? new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headerContent(model.promotion),
          model.promotion!=null?_commodityContent(model.promotion.products):Container(),
          model.promotion!=null?_bottomContent(model.promotion.promotionCode,model.promotion.promotionName):Container()
        ],
      ):new Container(),
    );
  }

  /// 商品集合--头部样式
  Widget _headerContent(PromotionModel model){
    return model!=null?new FractionallySizedBox(
        child: InkWell(
          onTap: (){
            _searchRequest(model.promotionCode);
          },
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(bottom: 10,top: 20),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 1,
                        width: ScreenAdapter.width(20),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConfig.assistLineColor),
                        ),
                      ),
                    ),
                    new Text(model.promotionName,softWrap: false,
                      style: TextStyle(color: AppConfig.fontBackColor,fontWeight:FontWeight.w600,fontSize: ScreenAdapter.size(32)),),
                    Expanded(
                      child: Container(
                        height: 1,
                        width: ScreenAdapter.width(20),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppConfig.assistLineColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.getPixelRatio()*ScreenAdapter.height(125),
                child: CachedNetworkImage(imageUrl: "${model.promotionPic}${ConstConfig.BANNER_FOUR_SIZE}",fit: BoxFit.fitWidth,),
              )
            ],
          ),
        )
    ):Container();
  }

  /// 商品列表
  Widget _commodityContent(List<CommodityModels> products){
    return new Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: new Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: products.map((item){
          String title = item.prodName;
          if(item.prodName.length>10){
            title = title.substring(0,10) + "...";
          }
          return InkWell(
            onTap: (){
              /// 跳转商品详情
              _commodityDetail(types:item.shopID,prodID: item.prodID);
            },
            child: new Container(
              width: ScreenAdapter.getScreenWidth()/3.8,
              margin: EdgeInsets.only(top: 10),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    height: ScreenAdapter.height(180),
                    child: item.prodPic!=null?new CachedNetworkImage(imageUrl:"${item.prodPic}${ConstConfig.BANNER_TWO_SIZE}",fit: BoxFit.fitWidth):
                    Image.asset("assets/images/default/default_squre_img.png",fit: BoxFit.fitWidth,),
                  ),
                  new Container(
                    padding:EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(title,overflow: TextOverflow.ellipsis,softWrap: false,
                          style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  new Container(
                    padding:EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomsWidget().priceTitle(price: item.salesPriceRange,
                            fontWeight: FontWeight.w500,fontSize: ScreenAdapter.size(24))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _bottomContent(String promotionCode,String name){
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 10,top: 20),
        child: InkWell(
          onTap: (){
            _searchRequest(promotionCode);
          },
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("查看全部",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: ScreenAdapter.size(26)),),
              new Icon(Icons.arrow_right)
            ],
          ),
        )
    );
  }
}
