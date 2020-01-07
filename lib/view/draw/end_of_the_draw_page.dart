import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/end_of_the_draw_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///进入店铺抽签登记页
class EndOfTheDrawPage extends PageProvideNode {
  final EndOfTheDrawProvide _provide = EndOfTheDrawProvide();
  final Map pics;
  EndOfTheDrawPage({this.pics}) {
    mProviders.provide(Provider<EndOfTheDrawProvide>.value(_provide));
    _provide.picsList = pics['pics'];
    _provide.shopsModel = pics['shops'];
    //_provide.stepsModel = pics['steps'];
    _provide.smodel = pics['steps'];
    print('stepsdrawID========>${_provide.smodel.length}');
    print('stepsstepIdx========>${_provide.smodel}');
    print('stepsstepName========>${_provide.smodel}');

    print('length====>${_provide.picsList.length}');
    print('shopsModel====>${_provide.shopsModel}');
    print('shopsModeldrawID====>${_provide.shopsModel.drawID}');
// 'longitude':provide.longitude,
    // 'latitude':provide.latitude
    _provide.drawID = _provide.shopsModel.drawID;
    _provide.shopID = _provide.shopsModel.shopID;
    _provide.longitude = pics['longitude'];
    _provide.latitude = pics['latitude'];
    print('longitude====>${_provide.longitude}');
    print('latitude====>${_provide.latitude}');
  }

  @override
  Widget buildContent(BuildContext context) {
    return EndOfTheDrawContentPage(_provide);
  }
}

class EndOfTheDrawContentPage extends StatefulWidget {
  final EndOfTheDrawProvide provide;
  EndOfTheDrawContentPage(this.provide);
  @override
  _EndOfTheDrawContentPageState createState() =>
      _EndOfTheDrawContentPageState();
}

class _EndOfTheDrawContentPageState extends State<EndOfTheDrawContentPage> {
  EndOfTheDrawProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;

    ///加载进入店铺抽签登记页
    _loadLotteryRegistrationPage();
  }

  _loadLotteryRegistrationPage() {
    if (Platform.isAndroid) {
      provide.platform = 'android';
    } else if (Platform.isIOS) {
      provide.platform = 'ios';
    }
    provide
        .loadLotteryRegistrationPage()
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .doOnDone(() {})
        .listen((items) {
      print('items.data=================> ${items.data}');
      if (items.data != null) {
        provide.lotteryRegistrationPageModel =
            LotteryRegistrationPageModel.fromJson(items.data);
        print('status====>${provide.lotteryRegistrationPageModel.status}');
        if (provide.lotteryRegistrationPageModel.status == 0) {
          provide.buttonName = '未开始';
        } else if (provide.lotteryRegistrationPageModel.status == 2) {
          provide.buttonName = '已结束';
        } else if (provide.lotteryRegistrationPageModel.status == 1) {
          print('=====>${provide.lotteryRegistrationPageModel.locatedIn}');
          if (provide.lotteryRegistrationPageModel.locatedIn) {
            if (provide.lotteryRegistrationPageModel.registered) {
              provide.buttonName = '查看登记';
              provide.buttonStatus = 0;
            } else {
              provide.buttonName = '去登记';
              provide.buttonStatus = 1;
            }
          } else {
            provide.buttonName = '不在服务范围';
            provide.buttonStatus = 2;
          }
        }
        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('抽签'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: ScreenAdapter.size(60),
          ),
        ),
      ),
      body: LoadStateLayout(
        state: _loadState,
        loadingContent: '加载中...',
        successWidget: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              _setupHead(),
              _setupBody(),
              _setupEnd(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
          onTap: () {
            print('按钮被点击');

            print('status====>${provide.lotteryRegistrationPageModel.status}');
            //  Navigator.pushNamed(context, '/registrationInformationPage',
            //       arguments: {
            //         'lotteryRegistrationPageModel':
            //             provide.lotteryRegistrationPageModel
            //       });

            if (provide.buttonStatus == 1) {
              Navigator.pushNamed(context, '/registrationInformationPage',
                  arguments: {
                    'lotteryRegistrationPageModel':
                        provide.lotteryRegistrationPageModel,
                    'longitude': provide.longitude,
                    'latitude': provide.latitude
                  });
            }

            if (provide.buttonStatus == 0) {
              Navigator.pushNamed(context, '/checkTheRegistrationPage',
                  arguments: {
                    'drawID': provide.lotteryRegistrationPageModel.drawID,
                    'shopID': provide.lotteryRegistrationPageModel.shopID,
                  });
            }
            if (provide.buttonStatus == 2) {}
          },
          child: Container(
            height: ScreenAdapter.height(120),
            child: Center(
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black87),
                    color:
                        provide.buttonStatus == 0 || provide.buttonStatus == 1
                            ? Color.fromRGBO(146, 169, 201, 1.0)
                            : Color.fromRGBO(248, 248, 248, 1.0)),
                child: Center(
                  child: Text(
                    provide.buttonName == null ? '' : provide.buttonName,
                    style: TextStyle(
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w800,
                        color: provide.buttonStatus == 0 ||
                                provide.buttonStatus == 1
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Provide<EndOfTheDrawProvide> _setupHead() {
    return Provide<EndOfTheDrawProvide>(
      builder:
          (BuildContext context, Widget child, EndOfTheDrawProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(550),
          color: Colors.white,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                provide.picsList[index].picUrl,
                width: ScreenAdapter.width(450),
                height: ScreenAdapter.width(450),
                fit: BoxFit.contain,
              );
            },
            itemCount: provide.picsList.length,
            viewportFraction: 0.8,
            scale: 0.5,
          ),
        );
      },
    );
  }

  Provide<EndOfTheDrawProvide> _setupBody() {
    return Provide<EndOfTheDrawProvide>(
      builder:
          (BuildContext context, Widget child, EndOfTheDrawProvide provide) {
        return Container(
          width: ScreenAdapter.width(680),
          // height: ScreenAdapter.height(520),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenAdapter.height(50),
              ),
              Center(
                child: Text(
                  provide.lotteryRegistrationPageModel.prodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(37),
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Center(
              //   child: Text(
              //     '抽签资格',
              //     style: TextStyle(
              //         fontSize: ScreenAdapter.size(40),
              //         fontWeight: FontWeight.w600),
              //   ),
              // ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              // Center(
              //   child: Text(
              //     '${provide.lotteryRegistrationPageModel.shopName}  |  ￥${provide.lotteryRegistrationPageModel.prodPrice}',
              //     style: TextStyle(
              //         // color: Color.fromRGBO(167, 166, 171, 1.0),
              //         // fontSize: ScreenAdapter.size(30),
              //         //fontWeight: FontWeight.w600
              //         ),
              //   ),
              // ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                //  color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      provide.shopsModel.shopName,
                      style: TextStyle(
                        fontSize: ScreenAdapter.size(30),
                        // fontWeight: FontWeight.w600,
                        // color: Color.fromRGBO(177, 177, 177, 1.0)
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Container(
                        width: ScreenAdapter.size(4),
                        height: ScreenAdapter.height(50),
                        color: Color.fromRGBO(220, 220, 220, 1.0)),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Text(
                      '￥' +
                          provide.lotteryRegistrationPageModel.prodPrice
                              .toString(),
                      style: TextStyle(
                        fontSize: ScreenAdapter.size(30),
                        // fontWeight: FontWeight.w600,
                        // color: Color.fromRGBO(177, 177, 177, 1.0)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '尺码: ${provide.lotteryRegistrationPageModel.prodSizeRange}',
                  style: TextStyle(
                      // fontSize: ScreenAdapter.size(30),
                      // fontWeight: FontWeight.w600,
                      //color: Color.fromRGBO(177, 177, 177, 1.0)
                      ),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '${provide.lotteryRegistrationPageModel.endTime} 截止登记',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(30),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(20),
              ),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black54,
                ),
              ),
              Container(
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(170),
                  child: provide.smodel.length > 4
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provide.smodel.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenAdapter.width(20)),
                                  width: ScreenAdapter.width(130),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: ScreenAdapter.width(18),
                                            height: ScreenAdapter.width(18),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    202, 202, 202, 1.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        ScreenAdapter.width(
                                                            10)))),
                                            child: Center(
                                              child: Container(
                                                width: ScreenAdapter.width(8),
                                                height: ScreenAdapter.width(8),
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        152, 152, 160, 1.0),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenAdapter.width(
                                                                10)))),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenAdapter.width(10),
                                          ),
                                          Text(
                                            'STEP ${provide.smodel[index].stepIdx}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    150, 150, 150, 1.0)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenAdapter.height(10),
                                      ),
                                      Text(
                                        provide.smodel[index].stepName,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                150, 150, 150, 1.0),
                                            fontSize: ScreenAdapter.size(30)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(

                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenAdapter.width(18),
                                      height: ScreenAdapter.width(18),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              202, 202, 202, 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenAdapter.width(10)))),
                                      child: Center(
                                        child: Container(
                                          width: ScreenAdapter.width(8),
                                          height: ScreenAdapter.width(8),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  152, 152, 160, 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenAdapter.width(
                                                          10)))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenAdapter.width(10),
                                    ),
                                    Text(
                                      'STEP ${provide.smodel[0].stepIdx}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(10),
                                ),
                                Text(
                                  provide.smodel[0].stepName,
                                  style: TextStyle(
                                      color: Color.fromRGBO(150, 150, 150, 1.0),
                                      fontSize: ScreenAdapter.size(30)),
                                )
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenAdapter.width(18),
                                      height: ScreenAdapter.width(18),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              202, 202, 202, 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenAdapter.width(10)))),
                                      child: Center(
                                        child: Container(
                                          width: ScreenAdapter.width(8),
                                          height: ScreenAdapter.width(8),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  152, 152, 160, 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenAdapter.width(
                                                          10)))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenAdapter.width(10),
                                    ),
                                    Text(
                                      'STEP ${provide.smodel[1].stepIdx}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(10),
                                ),
                                Text(
                                  provide.smodel[1].stepName,
                                  style: TextStyle(
                                      color: Color.fromRGBO(150, 150, 150, 1.0),
                                      fontSize: ScreenAdapter.size(30)),
                                )
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    provide.smodel.length == 3?
                                    Container(
                                      width: ScreenAdapter.width(18),
                                      height: ScreenAdapter.width(18),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(
                                              202, 202, 202, 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenAdapter.width(10)))),
                                      child: Center(
                                        child: Container(
                                          width: ScreenAdapter.width(8),
                                          height: ScreenAdapter.width(8),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  152, 152, 160, 1.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenAdapter.width(
                                                          10)))),
                                        ),
                                      ),
                                    ):Container(
                                      
                                    )
                                    ,
                                    SizedBox(
                                      width: ScreenAdapter.width(10),
                                    ),
                                    provide.smodel.length == 3
                                        ? Text(
                                            'STEP ${provide.smodel[2].stepIdx}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    150, 150, 150, 1.0)),
                                          )
                                        : Container()
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(10),
                                ),
                                provide.smodel.length == 3
                                    ? Text(
                                        provide.smodel[2].stepName,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                150, 150, 150, 1.0),
                                            fontSize: ScreenAdapter.size(30)),
                                      )
                                    : Container()
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    provide.smodel.length == 4
                                        ? Container(
                                            width: ScreenAdapter.width(18),
                                            height: ScreenAdapter.width(18),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    202, 202, 202, 1.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        ScreenAdapter.width(
                                                            10)))),
                                            child: Center(
                                              child: Container(
                                                width: ScreenAdapter.width(8),
                                                height: ScreenAdapter.width(8),
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        152, 152, 160, 1.0),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            ScreenAdapter.width(
                                                                10)))),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: ScreenAdapter.width(10),
                                    ),
                                    provide.smodel.length == 4
                                        ? Text(
                                            'STEP ${provide.smodel[3].stepIdx}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    150, 150, 150, 1.0)),
                                          )
                                        : Container()
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenAdapter.height(10),
                                ),
                                provide.smodel.length == 4
                                    ? Text(
                                        provide.smodel[3].stepName,
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                150, 150, 150, 1.0),
                                            fontSize: ScreenAdapter.size(30)),
                                      )
                                    : Container()
                              ],
                            ),
                          ],
                        )),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<EndOfTheDrawProvide> _setupEnd() {
    return Provide<EndOfTheDrawProvide>(
      builder:
          (BuildContext context, Widget child, EndOfTheDrawProvide provide) {
        return Column(
          children: <Widget>[
            Center(
              child: Container(
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(268),
                //  color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenAdapter.height(48),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '中奖名单',
                            style: TextStyle(fontSize: ScreenAdapter.size(30)),
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(20),
                        ),
                        provide.lotteryRegistrationPageModel.drawStatus < 2
                            ? Container()
                            : Container(
                                child: Text(
                                  '(本次中签的前6位用户)',
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.size(23),
                                      color:
                                          Color.fromRGBO(150, 150, 150, 1.0)),
                                ),
                              ),
                      ],
                    ),
                    provide.lotteryRegistrationPageModel.drawStatus < 2
                        ? Container(
                            width: ScreenAdapter.width(680),
                            height: ScreenAdapter.height(150),
                            child: Center(
                              child: Text(
                                '敬请期待',
                                style: TextStyle(
                                    fontSize: ScreenAdapter.size(30),
                                    color: Colors.black54),
                              ),
                            ),
                          )
                        : Container(
                            width: ScreenAdapter.width(680),
                            height: ScreenAdapter.height(150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles[0] ==
                                              null
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[0],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                    SizedBox(
                                      height: ScreenAdapter.height(10),
                                    ),
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles.length <
                                              2
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[1],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles.length <
                                              3
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[2],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                    SizedBox(
                                      height: ScreenAdapter.height(10),
                                    ),
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles.length <
                                              4
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[3],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles.length <
                                              5
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[4],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                    SizedBox(
                                      height: ScreenAdapter.height(10),
                                    ),
                                    Text(
                                      provide.lotteryRegistrationPageModel
                                                  .winnerMobiles.length !=
                                              6
                                          ? ''
                                          : provide.lotteryRegistrationPageModel
                                              .winnerMobiles[5],
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              150, 150, 150, 1.0)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(1),
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(48),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '活动介绍',
                style: TextStyle(fontSize: ScreenAdapter.size(35)),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(48),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Html(
                data: provide.lotteryRegistrationPageModel.drawRule,
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
          ],
        );
      },
    );
  }
}
