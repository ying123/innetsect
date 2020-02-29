import 'dart:ui';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/coupons/coupons.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/coupons/all_coupns_provide.dart';

import 'package:innetsect/view/mall/coupons/hj_expansion_tile_.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';
import 'package:extended_text/extended_text.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class AllCoupnsPage extends PageProvideNode {
  final AllCoupnsProvide _provide = AllCoupnsProvide();
  final int index;
  AllCoupnsPage(this.index) {
    mProviders.provide(Provider<AllCoupnsProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return AllCoupnsContentPage(_provide, index);
  }
}

class AllCoupnsContentPage extends StatefulWidget {
  final AllCoupnsProvide _provide;
  final int index;
  AllCoupnsContentPage(this._provide, this.index);
  @override
  _AllCoupnsContentPageState createState() => _AllCoupnsContentPageState();
}

class _AllCoupnsContentPageState extends State<AllCoupnsContentPage> {
  AllCoupnsProvide _provide;
  int indexPage;
  //控制器
  EasyRefreshController _controller;
  int pageNo = 1;
  LoadState _loadState = LoadState.State_Loading;

  @override
  void initState() {
    _provide ??= widget._provide;
    indexPage ??= widget.index;

    print('indexPage====================================>$indexPage');
    super.initState();
    _provide.cleanCouponsModel();
    _dontCouponsData(pageNo: pageNo);
  }

  _dontCouponsData({int pageNo}) {
   if (indexPage == 1) {
      _provide
        .dontCouponsRepo( 'unused',pageNo: pageNo)
        .doOnListen(() {})
        .doOnError(() {})
        .listen((items) {
      print('====================${items.data}');
      if (items.data != null || items != null) {
        _provide.addDontCouponsMode(CouponsModelList.fromJson(items.data).list);
      }
      setState(() {
        _loadState = LoadState.State_Success;
      });
    }, onError: (e, errorTreact) {});
   }
   if (indexPage == 2) {
      _provide
        .dontCouponsRepo( 'used',pageNo: pageNo)
        .doOnListen(() {})
        .doOnError(() {})
        .listen((items) {
      print('====================${items.data}');
      if (items.data != null || items != null) {
        _provide.addDontCouponsMode(CouponsModelList.fromJson(items.data).list);
      }
      setState(() {
        _loadState = LoadState.State_Success;
      });
    }, onError: (e, errorTreact) {});
   }
   if (indexPage == 3) {
      _provide
        .dontCouponsRepo( 'expired',pageNo: pageNo)
        .doOnListen(() {})
        .doOnError(() {})
        .listen((items) {
      print('====================${items.data}');
      if (items.data != null || items != null) {
        _provide.addDontCouponsMode(CouponsModelList.fromJson(items.data).list);
      }
      setState(() {
        _loadState = LoadState.State_Success;
      });
    }, onError: (e, errorTreact) {});
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LoadStateLayout(
            state: _loadState,
            loadingContent: '加载中...',
            successWidget:_provide.dontCouponsModelList.length == 0? 
              Container(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ScreenAdapter.height(220),
                ),
                Image.asset(
                  'assets/images/mall/no_data.png',width: ScreenAdapter.width(280),height: ScreenAdapter.width(280),
                ),
                SizedBox(
                  height: ScreenAdapter.height(30),
                ),
                Text('暂无相关数据'),
              ],
            )
          ):
             ListWidgetPage(
              controller: _controller,
              onRefresh: () async {
                setState(() {
                  _loadState = LoadState.State_Loading;
                });
                pageNo = 1;
                _provide.cleanCouponsModel();
                _dontCouponsData(pageNo: pageNo);
              },
              onLoad: () async {
               
                pageNo++;
               _dontCouponsData(pageNo: pageNo);
                //  setState(() {
                //   _loadState = LoadState.State_Loading;
                // });
              },
              child: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  setBody(),
                ]))
              ],
            )));
  }

  Provide<AllCoupnsProvide> setBody() {
    return Provide<AllCoupnsProvide>(
      builder: (BuildContext context, Widget child, AllCoupnsProvide provide) {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: provide.dontCouponsModelList.length,
            itemBuilder: (BuildContext build, int index) {
              return HJExpansionTile(
                initiallyExpanded: false ,//初始状态不展开
                title: Container(
                  width: double.infinity,
                  height: ScreenAdapter.height(250),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(200),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: ScreenAdapter.width(206),
                                height: ScreenAdapter.height(166),
                                child: provide.dontCouponsModelList[index]
                                            .csType ==
                                        0 && indexPage == 1
                                    ? Image.asset(
                                        'assets/images/立减券.png',
                                        fit: BoxFit.contain,
                                      )
                                    : provide.dontCouponsModelList[index]
                                                .csType ==
                                            1 && indexPage == 1
                                        ? Image.asset(
                                            'assets/images/满减券.png',
                                            fit: BoxFit.contain,
                                          )
                                        : provide.dontCouponsModelList[index]
                                                    .csType ==
                                                2&& indexPage == 1
                                            ? Image.asset(
                                                'assets/images/折扣券.png',
                                                fit: BoxFit.contain,
                                              )
                                            : provide
                                                        .dontCouponsModelList[
                                                            index]
                                                        .csType ==
                                                    4&& indexPage == 1
                                                ? Image.asset(
                                                    'assets/images/运费券.png',
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.asset(
                                                    'assets/images/优惠券-灰.png',
                                                    fit: BoxFit.contain,
                                                  ),
                              ),
                              Container(
                                width: ScreenAdapter.width(206),
                                height: ScreenAdapter.height(166),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SizedBox(
                                      height: ScreenAdapter.height(20),
                                    ),
                                   provide.dontCouponsModelList[index].csType != 2? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '￥',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(28),
                                              fontWeight: FontWeight.w600
                                              ),
                                        ),
                                        Text(
                                          provide.dontCouponsModelList[index]
                                              .couponValue
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(50),
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ):Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        
                                        Text(
                                          provide.dontCouponsModelList[index]
                                              .couponValue
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(50),
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          '折',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(28),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      provide.dontCouponsModelList[index].useLimitDesc,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenAdapter.size(20)),
                                    ),
                                    SizedBox(
                                      height: ScreenAdapter.height(20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                              width: ScreenAdapter.width(460),
                              height: ScreenAdapter.height(166),
                              //  color: Colors.yellow,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: ExtendedText.rich(
                                              TextSpan(children: <InlineSpan>[
                                        WidgetSpan(
                                          child: provide
                                                      .dontCouponsModelList[
                                                          index]
                                                      .csType ==
                                                  0
                                              ? Image.asset(
                                                  'assets/images/lj.jpg',
                                                  width:
                                                      ScreenAdapter.width(100),height: ScreenAdapter.height(50)
                                                )
                                              : provide
                                                          .dontCouponsModelList[
                                                              index]
                                                          .csType ==
                                                      1
                                                  ? Image.asset(
                                                      'assets/images/mj.jpg',
                                                      width:
                                                          ScreenAdapter.width(
                                                              100),height: ScreenAdapter.height(50)
                                                    )
                                                  : provide
                                                              .dontCouponsModelList[
                                                                  index]
                                                              .csType ==
                                                          2
                                                      ? Image.asset(
                                                          'assets/images/zk.jpg',
                                                          width: ScreenAdapter
                                                              .width(100),height: ScreenAdapter.height(50),
                                                        )
                                                      : provide
                                                                  .dontCouponsModelList[
                                                                      index]
                                                                  .csType ==
                                                              4
                                                          ?
                                                           Image.asset(
                                                              'assets/images/yf.jpg', width: ScreenAdapter
                                                              .width(100),height: ScreenAdapter.height(50),
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : Container(),
                                        ),
                                        TextSpan(text: ' '),
                                        TextSpan(
                                            text: provide.dontCouponsModelList[index].csName,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.size(23
                                                  ),fontWeight: FontWeight.w600
                                                  )),
                                      ]))),
                                    ],
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: ScreenAdapter.height(78),
                                      child: Container(
                                        width: ScreenAdapter.width(460),
                                        height: ScreenAdapter.height(55),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              provide
                                                      .dontCouponsModelList[
                                                          index]
                                                      .givenTime
                                                      .split(' ')[0] +
                                                  '-' +
                                                  provide
                                                      .dontCouponsModelList[
                                                          index]
                                                      .expiryTime
                                                      .split(' ')[0],
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.size(20)),
                                            ),
                                            Expanded(child: Container()),
                                            //  SizedBox(
                                            //   width: ScreenAdapter.width(120),
                                            // ),
                                            indexPage == 1
                                                ? Container(
                                                    alignment: Alignment.center,
                                                    width: ScreenAdapter.width(
                                                        130),
                                                    height:
                                                        ScreenAdapter.height(
                                                            44),
                                                    decoration: BoxDecoration(

                                                       color: provide.dontCouponsModelList[index].csType == 0? Color.fromRGBO(
                                                            68, 141, 227, 1.0)
                                                            :provide.dontCouponsModelList[index].csType == 1? Color.fromRGBO(135, 170, 207, 1.0)
                                                            :provide.dontCouponsModelList[index].csType == 2? Color.fromRGBO(0, 180, 202, 1.0)
                                                            :provide.dontCouponsModelList[index].csType == 4? Color.fromRGBO(0, 194, 136, 1.0)
                                                            :Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    ScreenAdapter.width(
                                                                        25)))),
                                                    child: Text(
                                                      '立即使用',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              ScreenAdapter
                                                                  .size(20)),
                                                    ))
                                                : Container(),
                                            // SizedBox(
                                            //   width: ScreenAdapter.width(10),
                                            // ),
                                          ],
                                        ),
                                      )),
                                  Positioned(
                                      left: 0,
                                      top: ScreenAdapter.height(120),
                                      child: Container(
                                        width: ScreenAdapter.width(460),
                                        height: ScreenAdapter.height(55),
                                        // color: Colors.blue,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '详细信息',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.size(22)),
                                            ),
                                            Expanded(child: Container()),
                                            SizedBox(
                                              width: ScreenAdapter.width(120),
                                            ),
                                            provide.listIndex == index && provide.expansionChanged ==true?
                                            Icon(
                                                  Icons.expand_more,
                                                 // Icons.chevron_right,
                                              size: ScreenAdapter.size(30),
                                            ):provide.listIndex == index && provide.expansionChanged ==false?
                                            Icon(
                                               Icons.chevron_right,
                                                 // Icons.expand_more,
                                              size: ScreenAdapter.size(30),
                                            ):Icon(
                                               Icons.chevron_right,
                                                 // Icons.expand_more,
                                              size: ScreenAdapter.size(30),
                                            ),
                                            SizedBox(
                                              width: ScreenAdapter.width(50),
                                            ),
                                          ],
                                        ),
                                      )),
                                      indexPage == 2 ? Positioned(
                                        right: 0,
                                        child: Image.asset('assets/images/已使用.png',width: ScreenAdapter.width(100),)
                                        ):indexPage == 3? Positioned(
                                          right: 0,
                                          child: Image.asset('assets/images/已过期.png',width: ScreenAdapter.width(100),)
                                          ):Container()
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                // trailing: Container(
                //   width: ScreenAdapter.width(90),
                //   height:  ScreenAdapter.width(200),
                //   color: Colors.blue,
                //   child: Icon(Icons.chevron_right),
                // ),
                onExpansionChanged: (value) {
                  print('展开===============》$value $index');
                  provide.expansionChanged = value;
                  provide.listIndex = index;
                  
                },
                
                // subtitle: Container(
                //   width:ScreenAdapter.width(100),
                //   height:ScreenAdapter.width(80),
                //   color: Colors.blue,
                // ),
                backgroundColor:
                    Theme.of(context).accentColor.withOpacity(0.025),
                children: <Widget>[
                 Container(
                   alignment: Alignment.center,
                   width: double.infinity,
                  child: Text(provide.dontCouponsModelList[index].remark.toString()),
                 )
                ],
              );
            });
      },
    );
  }
}
