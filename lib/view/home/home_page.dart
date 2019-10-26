import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/animation_util.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/show_tickets/show_tickets.dart';
import 'package:innetsect/view/venues_map/venues_map_page.dart';
import 'package:innetsect/view/widget/pulltorefresh_flutter.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends PageProvideNode {
  final HomeProvide _provide = HomeProvide();
  HomePage() {
    mProviders.provide(Provider<HomeProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return HomeContentPage(_provide);
  }
}

class HomeContentPage extends StatefulWidget {
  final HomeProvide _provide;
  HomeContentPage(this._provide);
  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage>
    with TickerProviderStateMixin {
  HomeProvide _provide;

  ScrollController controller = new ScrollController();
  //For compatibility with ios ,must use RefreshAlwaysScrollPhysics ;为了兼容ios 必须使用RefreshAlwaysScrollPhysics
  ScrollPhysics scrollPhysics = new RefreshAlwaysScrollPhysics();
  //使用系统的请求
  var httpClient = new HttpClient();
  var url = "https://github.com/";
  var _result = "";
  String customRefreshBoxIconPath = "assets/images/icon_arrow.png";
  AnimationController customBoxWaitAnimation;
  int rotationAngle = 0;

  ///自定义标题提示文本
  String customHeaderTipText = "快尼玛给老子松手！";

  ///默认的刷新框提示文本
  String defaultRefreshBoxTipText = "快尼玛给老子松手！";

  ///button等其他方式，通过方法调用触发下拉刷新
  TriggerPullController triggerPullController = new TriggerPullController();
  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
    //这个是刷新时控件旋转的动画，用来使刷新的Icon动起来
    customBoxWaitAnimation = new AnimationController(
        duration: const Duration(milliseconds: 1000 * 100), vsync: this);
    //第一次layout后会被调用
    //WidgetsBinding.instance.addPostFrameCallback((context){
    //  triggerPullController.triggerPull();
    //});
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
                fontSize: ScreenAdapter.size(40),
                fontWeight: FontWeight.w600,
                color: AppConfig.fontPrimaryColor),
          ),
          centerTitle: true,
          leading: Container(),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(38), 0, 0),
                child: Text(
                  '进入商城',
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
        body: new PullAndPush(
          //如果你headerRefreshBox和footerRefreshBox全都自定义了，则default**系列的属性均无效，假如有一个RefreshBox是用默认的（在该RefreshBox Enable的情况下）则default**系列的属性均有效
          //If your headerRefreshBox and footerRefreshBox are all customizable，then the default** attributes of the series are invalid，
          // If there is a RefreshBox is the default（In the case of the RefreshBox Enable）then the default** attributes of the series are valid
          defaultRefreshBoxTipText: defaultRefreshBoxTipText,
          headerRefreshBox: _getCustomHeaderBox(),
          triggerPullController: triggerPullController,

          //你也可以自定义底部的刷新栏；you can customize the bottom refresh box
          animationStateChangedCallback: (AnimationStates animationStates,
              RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
            _handleStateCallback(animationStates, refreshBoxDirectionStatus);
          },
          listView: new ListView(
            //ListView的Ite
            controller: controller,
            // shrinkWrap: true,
            physics: scrollPhysics,
            //physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _setupSwiperImage(),
              _setupCenterWidget(),
              _setupListItemsContent(),
            ],
          ),
          loadData: (isPullDown) async {
            await _loadData(isPullDown);
          },
          scrollPhysicsChanged: (ScrollPhysics physics) {
            //这个不用改，照抄即可；This does not need to change，only copy it
            setState(() {
              scrollPhysics = physics;
            });
          },
        ));
  }

  Provide<HomeProvide> _setupListItemsContent() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        var itemWith = (ScreenAdapter.getScreenWidth()) / 1;
        return Container(
          child: Wrap(
            runSpacing: 0,
            spacing: 0,
            children: provide.listItems.map((value) {
              return Container(
                // padding: EdgeInsets.all(10),

                width: itemWith,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: AspectRatio(
                        //防止服务器返回的图片大小不一致导致高度不一致问题
                        aspectRatio: 2 / 1,
                        child: Image.asset(
                          value['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value['title'],
                          softWrap: true,
                          style: TextStyle(fontSize: ScreenAdapter.size(30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenAdapter.height(20),
                          left: ScreenAdapter.width(20)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle1'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Container(
                            width: ScreenAdapter.width(85),
                            height: ScreenAdapter.height(30),
                            color: AppConfig.fontPrimaryColor,
                            child: Center(
                              child: Text(
                                value['subTitle2'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(21)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(10),
                          ),
                          Text(
                            value['time'],
                            style: TextStyle(
                                color: Color.fromRGBO(180, 180, 180, 1.0)),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Image.asset(
                            'assets/images/关注.png',
                            fit: BoxFit.cover,
                            width: ScreenAdapter.width(30),
                            height: ScreenAdapter.height(25),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(6),
                          ),
                          Text(value['focusNuber'],
                              style: TextStyle(
                                  color: Color.fromRGBO(180, 180, 180, 1.0))),
                          SizedBox(
                            width: ScreenAdapter.width(35),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.height(38),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Provide<HomeProvide> _setupCenterWidget() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(250),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(40),
                child: Center(
                  child: Text(
                    provide.advertising,
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.size(30),
                    ),
                  ),
                ),
              ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(200),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(60),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('够买门票被点击');
                        Navigator.of(context).push(CommonUtil.createRoute(
                            AnimationUtil.getBottominAnilmation(),
                            ShowTicketsPage()));  
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(45), 0, 0),
                          child: Image.asset(
                            'assets/images/够买门票.png',
                            width: ScreenAdapter.size(110),
                          )),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('签到绑定被点击');
                        Navigator.pushNamed(context, '/bindingSignIn');
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(45), 0, 0),
                          child: Image.asset(
                            'assets/images/签到绑定.png',
                            width: ScreenAdapter.size(110),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap:scan,
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(45), 0, 0),
                          child: Image.asset(
                            'assets/images/排队扫码.png',
                            width: ScreenAdapter.size(110),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('场馆地图');
                         Navigator.of(context).push(CommonUtil.createRoute(
                            AnimationUtil.getBottominAnilmation(),
                            VenuesMapPage()));  
                      },
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              0, ScreenAdapter.height(45), 0, 0),
                          child: Image.asset(
                            'assets/images/场馆地图.png',
                            width: ScreenAdapter.size(110),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(60),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
///二维码扫描
 Future scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() => _provide.barcode = barcode);
    } on Exception catch (e) {
      if (e == scanner.CameraAccessDenied) {
        setState(() {
          _provide.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => _provide.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => _provide.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => _provide.barcode = 'Unknown error: $e');
    }
  }


  ///轮播图
  Provide<HomeProvide> _setupSwiperImage() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(470),
          color: Colors.white,
          child: Center(
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(420),
              color: Colors.white,
              child: Swiper(
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
                              imageUrl: provide.bannerImages[index],
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
                itemCount: provide.bannerImages.length,
                // pagination: SwiperPagination(),
                autoplay: true,
                duration: 300,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        );
      },
    );
  }

  ///加载数据
  Future _loadData(bool isPullDown) async {
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        _result = await utf8.decoder.bind(response).join();
        setState(() {
          //拿到数据后，对数据进行梳理
          if (isPullDown) {
            print('isPullDown');
            _provide.listItems.clear();
            _provide.listItems.addAll(_provide.addListItems);
          } else {
            _provide.listItems.addAll(_provide.addListItems);
          }
        });
      } else {
        _result = 'error code : ${response.statusCode}';
      }
    } catch (exception) {
      _result = '网络异常';
    }
    print(_result);
  }

  ///获取自定义标题框
  Widget _getCustomHeaderBox() {
    return new Container(
        color: Colors.grey,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Align(
              alignment: Alignment.centerLeft,
              child: new RotatedBox(
                quarterTurns: rotationAngle,
                child: new RotationTransition(
                  //布局中加载时动画的weight
                  child: new Image.asset(
                    customRefreshBoxIconPath,
                    height: 45.0,
                    width: 45.0,
                    fit: BoxFit.cover,
                  ),
                  turns: new Tween(begin: 100.0, end: 0.0)
                      .animate(customBoxWaitAnimation)
                        ..addStatusListener((animationStatus) {
                          if (animationStatus == AnimationStatus.completed) {
                            customBoxWaitAnimation.repeat();
                          }
                        }),
                ),
              ),
            ),
            new Align(
              alignment: Alignment.centerRight,
              child: new ClipRect(
                child: new Text(
                  customHeaderTipText,
                  style:
                      new TextStyle(fontSize: 18.0, color: Color(0xffe6e6e6)),
                ),
              ),
            ),
          ],
        ));
  }

  ///处���刷新状态回调
  void _handleStateCallback(AnimationStates animationStates,
      RefreshBoxDirectionStatus refreshBoxDirectionStatus) {
    switch (animationStates) {
      //RefreshBox高度达到50,上下拉刷新可用;RefreshBox height reached 50，the function of load data is  available
      case AnimationStates.DragAndRefreshEnabled:
        setState(() {
          //3.141592653589793是弧度，角度为180度,旋转180度；3.141592653589793 is radians，angle is 180⁰，Rotate 180⁰
          rotationAngle = 2;
        });
        break;

      //开始加载数据时；When loading data starts
      case AnimationStates.StartLoadData:
        setState(() {
          customRefreshBoxIconPath = "assets/images/refresh.png";
          customHeaderTipText = "正尼玛在拼命加载.....";
        });
        customBoxWaitAnimation.forward();
        break;

      //加载完数据时；RefreshBox会留在屏幕2秒，并不马上消失，这里可以提示用户加载成功或者失败
      // After loading the data，RefreshBox will stay on the screen for 2 seconds, not disappearing immediately，Here you can prompt the user to load successfully or fail.
      case AnimationStates.LoadDataEnd:
        customBoxWaitAnimation.reset();
        setState(() {
          rotationAngle = 0;
          if (refreshBoxDirectionStatus == RefreshBoxDirectionStatus.PULL) {
            customRefreshBoxIconPath = "assets/images/icon_cry.png";
            customHeaderTipText = "加载失败！请重试";
          } else if (refreshBoxDirectionStatus ==
              RefreshBoxDirectionStatus.PUSH) {
            defaultRefreshBoxTipText = "可提示用户加载成功Or失败";
          }
        });
        break;

      //RefreshBox已经消失，并且闲置；RefreshBox has disappeared and is idle
      case AnimationStates.RefreshBoxIdle:
        setState(() {
          rotationAngle = 0;
          defaultRefreshBoxTipText = customHeaderTipText = "快尼玛给老子松手！";
          customRefreshBoxIconPath = "assets/images/icon_arrow.png";
        });
        break;
    }
  }
}
