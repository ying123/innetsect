import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/animation_util.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/advisory_details/advisory_details_page.dart';
import 'package:innetsect/view/show_tickets/show_tickets.dart';
import 'package:innetsect/view/venues_map/venues_map_page.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rxdart/rxdart.dart';

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
  final _subscriptions = CompositeSubscription();
  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
    _loadData();
  }

  _loadData() {
    print('开始加载数据');
    var s = _provide
        .homeDatas()
        .doOnListen(() {
          print('doOnListen');
        })
        .doOnCancel(() {})
        .listen((data) {
          AppConfig.userTools.setExhibitionID(data.data['exhibitionID'].toString());
          ///加载展会首页数据
          print('listen data->$data');
          for (var item in data.data['banners']) {
            //print('item:->${item['bannerPic']}');
            widget._provide.banneImages = item['bannerPic'];
          }
          for (var item in data.data['portlets']) {
            // print('item---->$item');
            widget._provide.portlets = item;

            for (var item in item['contents']) {
              //  print('item countents====>$item');
              widget._provide.contents = item;
            }
            
          }
          print('widget_provide.contents${widget._provide.contents}');
        }, onError: (e) {});
    _subscriptions.add(s);
  }

  @override
  void dispose() {
    _subscriptions.dispose();
    controller.dispose();
    super.dispose();
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
              // fontWeight: FontWeight.w600,
              color: AppConfig.fontPrimaryColor),
        ),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          GestureDetector(
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
      body: ListView(
        //ListView的Ite
        controller: controller,
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        //physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          _setupSwiperImage(),
          _setupCenterWidget(),
          _setupListItemsContent(),
        ],
      ),
    );
  }

  Provide<HomeProvide> _setupListItemsContent() {
    return Provide<HomeProvide>(
      builder: (BuildContext context, Widget child, HomeProvide provide) {
        var itemWith = (ScreenAdapter.getScreenWidth()) / 1;
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: provide.contents.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                print('${provide.contents[index]['title']}被点击');
                provide.contentID = provide.contents[index]['contentID'];
                 Navigator.of(context).push(CommonUtil.createRoute(
                            AnimationUtil.getBottominAnilmation(),
                            AdvisoryDetailsPage(provide.contentID)));
                
              },
              child: Wrap(
                runSpacing: 0,
                spacing: 0,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: itemWith,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 2 / 1,
                            child: Image.network(
                              provide.contents[index]['poster'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(0)),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              provide.contents[index]['title'],
                              softWrap: true,
                              style: TextStyle(fontSize: ScreenAdapter.size(30)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(0)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(120),
                                height: ScreenAdapter.height(30),
                                color: AppConfig.fontPrimaryColor,
                                child: Center(
                                  child: Text(
                                    provide.contents[index]['tags'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdapter.size(21)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenAdapter.width(10),
                              ),
                              // Container(
                              //   width: ScreenAdapter.width(85),
                              //   height: ScreenAdapter.height(30),
                              //   color: AppConfig.fontPrimaryColor,
                              //   child: Center(
                              //     child: Text(
                              //       value['subTitle1'],
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: ScreenAdapter.size(21)),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: ScreenAdapter.width(10),
                              // ),
                              // Container(
                              //   width: ScreenAdapter.width(85),
                              //   height: ScreenAdapter.height(30),
                              //   color: AppConfig.fontPrimaryColor,
                              //   child: Center(
                              //     child: Text(
                              //       value['subTitle2'],
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontSize: ScreenAdapter.size(21)),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: ScreenAdapter.width(10),
                              // ),
                              // Text(
                              //   value['time'],
                              //   style: TextStyle(
                              //       color: Color.fromRGBO(180, 180, 180, 1.0)),
                              // ),
                              // Expanded(
                              //   child: Container(),
                              // ),
                              // Image.asset(
                              //   'assets/images/关注.png',
                              //   fit: BoxFit.cover,
                              //   width: ScreenAdapter.width(30),
                              //   height: ScreenAdapter.height(25),
                              // ),
                              // SizedBox(
                              //   width: ScreenAdapter.width(6),
                              // ),
                              // Text(value['focusNuber'],
                              //     style: TextStyle(
                              //         color: Color.fromRGBO(180, 180, 180, 1.0))),
                              // SizedBox(
                              //   width: ScreenAdapter.width(35),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
                      onTap: scan,
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
      setState(() => _provide.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
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
              child: provide.bannerImages.length>0?Swiper(
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
              ):new Container(),
            ),
          ),
        );
      },
    );
  }
}
