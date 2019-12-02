import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/home_banners_model.dart';
import 'package:innetsect/data/exhibition/home_portlets_model.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/my/vip_card/vip_card_page.dart';
import 'package:innetsect/view/shopping/high_commodity_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
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

  HomePage() {
    mProviders.provide(Provider<HomeProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return HomeContentPage(_provide,_loginProvide,_detailProvide,_cartProvide);
  }
}

class HomeContentPage extends StatefulWidget {
  final HomeProvide _provide;
  final LoginProvide _loginProvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  HomeContentPage(this._provide,this._loginProvide,this._detailProvide,this._cartProvide);
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
            HomeBannersModelList.fromJson(item.data['banners']).list);
        _provide.addPortlets(
            HomePortletsModelList.fromJson(item.data['portlets']).list);
        String videoUrl = _provide.portletsModelList[0].contents[0].mediaFiles;
        _videoPlayerController = VideoPlayerController.network(videoUrl);
        _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: 9.5 / 5,
            autoPlay: false,
            autoInitialize: true,
            looping: true);

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
    _loginProvide.getUserInfo(context:context).doOnListen((){}).doOnCancel((){}).listen((userItem){
      if(userItem!=null&&userItem.data!=null){
        _loginProvide.setUserInfoModel(UserInfoModel.fromJson(userItem.data));
        // 解析二维码
        List list = result.split("&&");
        var json = {
          "qrType":list[0],
          "qrCode":list[1]
        };
        // 扫码
        _provide.qrCodeWhisk(json).doOnListen((){}).doOnCancel((){}).listen((item){
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
                _setupListItemsContent()
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
                  index: 0,
                  loop: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print('$index');
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
                  autoplay: true,
                  duration: 300,
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
                    _loadQrCode(barcode);

                  }on PlatformException catch(e){
                    if (e.code == scanner.CameraAccessDenied) {
                      //未授于App相机权限
                      print('未授于App相机权限');
                    }else
                      //扫码错误
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
                  Navigator.pushNamed(context, '/homePortletsDetailsPage',arguments: {"contentID":provide.portletsModelList[index].contents[0].contentID});
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
                            ? Chewie(
                          controller: _chewieController,
                        )
                            : Image.network(
                          provide.portletsModelList[index].contents[0].mediaFiles,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(185),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: ScreenAdapter.height(30),
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: ScreenAdapter.width(40),
                                ),
                                Container(
                                  width: ScreenAdapter.width(710),
                                  //height: ScreenAdapter.height(50),
                                  child: Text(
                                    provide.portletsModelList[index].contents[0].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(35),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: ScreenAdapter.height(20),
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: ScreenAdapter.width(40),
                                ),
                                Container(
                                  width: ScreenAdapter.width(150),
                                  height: ScreenAdapter.height(42),
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      provide.portletsModelList[index].contents[0].tags,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
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
}
