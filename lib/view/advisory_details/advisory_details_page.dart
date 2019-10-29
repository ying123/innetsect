import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/advisory_details/advisory_details_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_html/flutter_html.dart';

class AdvisoryDetailsPage extends PageProvideNode {
  final AdvisoryDetailsProvide _provide = AdvisoryDetailsProvide();
  final int contentID;
  AdvisoryDetailsPage(this.contentID) {
    mProviders.provide(Provider<AdvisoryDetailsProvide>.value(_provide));
    _provide.contentID = contentID;
    
  }
  @override
  Widget buildContent(BuildContext context) {
    return AdvisoryDatailsContentPage(_provide);
  }
}

class AdvisoryDatailsContentPage extends StatefulWidget {
  final AdvisoryDetailsProvide _provide;
  AdvisoryDatailsContentPage(this._provide);
  @override
  _AdvisoryDatailsContentPageState createState() =>
      _AdvisoryDatailsContentPageState();
}

class _AdvisoryDatailsContentPageState extends State<AdvisoryDatailsContentPage>
    with TickerProviderStateMixin {
  AdvisoryDetailsProvide _provide;
  final _subscriptions = CompositeSubscription();
  @override
  void initState() {
    _provide ??= widget._provide;
    print('AdvisoryDetailsProvide=>${_provide.contentID}');

    ///加载详情讯息数据
    _loadadvisoryDetails();
    super.initState();
  }

  _loadadvisoryDetails() {
    var s = _provide
        .loadadvisoryDetails(_provide.contentID)
        .doOnListen(() {})
        .doOnCancel(() {})
        .listen((data) {
      // print('data====>$data');
      _provide.advisoryDetailsData = data.data;
    }, onError: (e) {});
    _subscriptions.add(s);
  }

  @override
  Widget build(BuildContext context) {
    print('bbbbbbbbbbb--------->${_provide.advisoryDetailsData}');

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('资讯详情'),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/xiangxia.png',
                fit: BoxFit.none,
                width: ScreenAdapter.width(38),
                height: ScreenAdapter.width(38),
              )),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _setupSwiperImage(),
            _setupCenter(),
            _setupbottom(),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(20),
              color: Color.fromRGBO(248, 248, 248, 1.0),
            )
          ],
        ));
  }

  ///轮播图
  Provide<AdvisoryDetailsProvide> _setupSwiperImage() {
    return Provide<AdvisoryDetailsProvide>(
      builder:
          (BuildContext context, Widget child, AdvisoryDetailsProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(750),
          color: Colors.white,
          child: Center(
            child: Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(750),
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
                            height: ScreenAdapter.height(750),
                            child: provide.advisoryDetailsData == null
                                ? Container(
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: SpinKitFoldingCube(
                                        size: 50,
                                        color: Colors.yellow,
                                        controller: AnimationController(
                                            vsync: this,
                                            duration: const Duration(
                                                milliseconds: 1200)),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    fadeOutDuration:
                                        const Duration(milliseconds: 300),
                                    fadeInDuration:
                                        const Duration(milliseconds: 700),
                                    fit: BoxFit.cover,
                                    imageUrl: provide
                                        .advisoryDetailsData['pics'][index],
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
                itemCount: provide.advisoryDetailsData == null
                    ? 4
                    : provide.advisoryDetailsData['pics'].length,
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

  Provide<AdvisoryDetailsProvide> _setupCenter() {
    return Provide<AdvisoryDetailsProvide>(
      builder:
          (BuildContext context, Widget child, AdvisoryDetailsProvide provide) {
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: provide.advisoryDetailsData == null
              ? 2
              : provide.advisoryDetailsData['skus'].length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(185),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                  color: Colors.white),
              // color: Colors.yellow,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(40),
                  ),
                  Container(
                    width: ScreenAdapter.width(120),
                    height: ScreenAdapter.height(120),
                    child: provide.advisoryDetailsData == null
                        ? Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.yellow,
                                controller: AnimationController(
                                    vsync: this,
                                    duration:
                                        const Duration(milliseconds: 1200)),
                              ),
                            ),
                          )
                        : Image.network(provide.advisoryDetailsData['skus']
                            [index]['skuPic'],fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Container(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(40),
                    child: provide.advisoryDetailsData == null
                        ? Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.yellow,
                                controller: AnimationController(
                                    vsync: this,
                                    duration:
                                        const Duration(milliseconds: 1200)),
                              ),
                            ),
                          )
                        : Text(provide.advisoryDetailsData['skus'][index]
                            ['remark']),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(80),
                  ),
                  Container(
                    width: ScreenAdapter.width(80),
                    height: ScreenAdapter.height(80),
                    child: Icon(
                      Icons.chevron_right,
                      size: ScreenAdapter.size(60),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Provide<AdvisoryDetailsProvide> _setupbottom() {
    return Provide<AdvisoryDetailsProvide>(
      builder:
          (BuildContext context, Widget child, AdvisoryDetailsProvide provide) {
        return Column(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: ScreenAdapter.width(40)),
                  alignment: Alignment.centerLeft,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(130),
                  child: provide.advisoryDetailsData == null
                      ? Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: SpinKitFoldingCube(
                              size: 50,
                              color: Colors.yellow,
                              controller: AnimationController(
                                  vsync: this,
                                  duration: const Duration(milliseconds: 1200)),
                            ),
                          ),
                        )
                      : Text(
                          provide.advisoryDetailsData['subtitle'],
                        ),
                )
              ],
            ),
            Wrap(
              children: <Widget>[
                Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(20)),
                    alignment: Alignment.centerLeft,
                    width: ScreenAdapter.width(750),
                   // height: ScreenAdapter.height(130),
                    child: provide.advisoryDetailsData == null
                        ? Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: SpinKitFoldingCube(
                                size: 50,
                                color: Colors.yellow,
                                controller: AnimationController(
                                    vsync: this,
                                    duration:
                                        const Duration(milliseconds: 1200)),
                              ),
                            ),
                          )
                        : Html(
                            data: provide.advisoryDetailsData['contentDetail'],
                          ))
              ],
            ),
          ],
        );
      },
    );
  }
}
