import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/registration_information_provide.dart';
import 'package:innetsect/view/my/settings/protocol_page.dart';
import 'package:innetsect/view/registered/country_page.dart';
import 'package:provide/provide.dart';

///登记信息
class RegistrationInformationPage extends PageProvideNode {
  final RegistrationInformationProvide _provide =
      RegistrationInformationProvide();
  final Map lotteryRegistrationPageModel;
  RegistrationInformationPage({this.lotteryRegistrationPageModel}) {
    mProviders
        .provide(Provider<RegistrationInformationProvide>.value(_provide));
    _provide.lotteryRegistrationPageModel =
        lotteryRegistrationPageModel['lotteryRegistrationPageModel'];
    _provide.longitude = lotteryRegistrationPageModel['longitude'];
    _provide.latitude = lotteryRegistrationPageModel['latitude'];
    _provide.drawBySku = lotteryRegistrationPageModel['drawBySku'];
    _provide.drawProdID = lotteryRegistrationPageModel['drawProdID'];
    _provide.skus = lotteryRegistrationPageModel['skus'];
    _provide.drawAwardType = lotteryRegistrationPageModel['drawAwardType'];
    _provide.endTime = lotteryRegistrationPageModel['endTime'];

    print('longitude=============>${_provide.longitude}');
    print('latitude=============>${_provide.latitude}');
    print('drawBySku=============>${_provide.drawBySku}');
    print('drawProdID=============>${_provide.drawProdID}');
    print('skus=============>${_provide.skus}');
    print('drawAwardType=============>${_provide.drawAwardType}');
    print('endTime=============>${_provide.endTime}');
    print('登记信息');
  }

  @override
  Widget buildContent(BuildContext context) {
    return RegistrationInformationContentPage(_provide);
  }
}

class RegistrationInformationContentPage extends StatefulWidget {
  final RegistrationInformationProvide provide;
  RegistrationInformationContentPage(this.provide);
  @override
  _RegistrationInformationContentPageState createState() =>
      _RegistrationInformationContentPageState();
}

class _RegistrationInformationContentPageState
    extends State<RegistrationInformationContentPage> {
  RegistrationInformationProvide provide;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    print('===>登记信息');
    if (Platform.isAndroid) {
      provide.platform = 'android';
    } else if (Platform.isIOS) {
      provide.platform = 'ios';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('登记信息'),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _setupHead(),
            _setupBody(),
            _setupEnd(),
          ],
        ),
      ),
    );
  }

  Provide<RegistrationInformationProvide> _setupHead() {
    return Provide<RegistrationInformationProvide>(
      builder: (BuildContext context, Widget child,
          RegistrationInformationProvide provide) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            color: Colors.white,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(280),
            margin: EdgeInsets.only(
                left: ScreenAdapter.width(65), right: ScreenAdapter.width(65)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Container(
                    width: ScreenAdapter.width(710),
                    child: Text(
                      provide.lotteryRegistrationPageModel.registerPrompt,
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(28),
                          color: Color.fromRGBO(84, 84, 84, 1.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Provide<RegistrationInformationProvide> _setupBody() {
    return Provide<RegistrationInformationProvide>(
      builder: (BuildContext context, Widget child,
          RegistrationInformationProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(60),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(65),
                ),
                Text(
                  '姓名',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(35),
                      color: Color.fromRGBO(133, 133, 133, 1.0)),
                )
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
            Center(
              child: Container(
                width: ScreenAdapter.width(625),
                height: ScreenAdapter.height(90),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black54))),
                child: TextField(
                  enabled: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '请输入姓名',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none
                      // contentPadding: EdgeInsets.all(0)
                      ),
                  onChanged: (str) {
                    provide.userName = str;
                  },
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(30),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(65),
                ),
                Text(
                  '证件',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(35),
                      color: Color.fromRGBO(133, 133, 133, 1.0)),
                )
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
            Center(
              child: Container(
                width: ScreenAdapter.width(625),
                height: ScreenAdapter.height(90),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black54))),
                child: TextField(
                  enabled: true,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: '请输入证件号码',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none
                      // contentPadding: EdgeInsets.all(0)
                      ),
                  onChanged: (str) {
                    provide.certificate = str;
                  },
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(30),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(65),
                ),
                Text(
                  '手机号码',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(35),
                      color: Color.fromRGBO(133, 133, 133, 1.0)),
                )
              ],
            ),
            SizedBox(
              height: ScreenAdapter.height(20),
            ),
            Center(
              child: Container(
                  width: ScreenAdapter.width(625),
                  height: ScreenAdapter.height(90),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black54))),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/country_page.dart')
                              .then((value) {
                            print('=============>$value');
                            if (value == null) {
                              return;
                            }
                            provide.countryCode = value;
                          });
                        },
                        child: Container(
                          child: Text(
                            '+${provide.countryCode}',
                            style: TextStyle(fontSize: ScreenAdapter.size(30)),
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_right),
                      Container(
                        width: ScreenAdapter.width(490),
                        height: ScreenAdapter.height(90),
                        child: TextField(
                          enabled: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: '请输入手机号码',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                              // contentPadding: EdgeInsets.all(0)
                              ),
                          onChanged: (str) {
                            provide.phoneNumber = str;
                          },
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: ScreenAdapter.height(30),
            ),
            provide.drawBySku == true
                ? Row(
                    children: <Widget>[
                      SizedBox(
                        width: ScreenAdapter.width(65),
                      ),
                      Text(
                        '选择',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(35),
                            color: Color.fromRGBO(133, 133, 133, 1.0)),
                      )
                    ],
                  )
                : Container(),
            provide.drawBySku == true
                ? SizedBox(
                    height: ScreenAdapter.height(20),
                  )
                : Container(),
            provide.drawBySku == true
                ? Center(
                    child: InkWell(
                      onTap: () {
                        print('选择sku颜色被点击');
                        selectSkuAndColor(context);
                      },
                      child: Container(
                          width: ScreenAdapter.width(625),
                          height: ScreenAdapter.height(90),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black54))),
                          child: Row(
                            children: <Widget>[
                              Text(
                                provide.selectSkuAndColor == '请选择 颜色 尺码'
                                    ? "请选择 颜色 尺码"
                                    : "已选：${provide.selectSkuAndColor}",
                                style:
                                    TextStyle(fontSize: ScreenAdapter.size(28)),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          )),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  String selectSkuSpecs;
  int limitMaxQty = 0;
  selectSkuAndColor(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context1, setBottomSheetState) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 25,
                      width: double.infinity,
                      color: Colors.black54,
                    ),
                    Container(
                        height: ScreenAdapter.height(1000),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenAdapter.size(25)),
                              topRight: Radius.circular(ScreenAdapter.size(25)),
                            )),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(750),
                              height: ScreenAdapter.height(80),
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.clear)),
                                  SizedBox(
                                    width: ScreenAdapter.width(20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.width(680),
                              height: ScreenAdapter.height(80),
                              // color: Colors.yellow,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '选择规格',
                                style: TextStyle(
                                    fontSize: ScreenAdapter.size(30),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.width(680),
                              //  color:Colors.black,
                              alignment: Alignment.bottomLeft,
                              child: Wrap(
                                  spacing: 5,
                                  runSpacing: 10,
                                  children: provide.skus.map((value) {
                                    print('value=====================> $value');
                                    print(
                                        'skuName=====================> ${value.skuName}');
                                    print(
                                        'skuSpecs=====================> ${value.skuSpecs}');
                                    return InkWell(
                                      onTap: () {
                                        print(value);

                                        // Navigator.pop(context);
                                        setBottomSheetState(() {
                                          selectSkuSpecs = value.skuSpecs;
                                          limitMaxQty = value.limitMaxQty;
                                          provide.selectSkuAndColor =
                                              value.skuSpecs;
                                          provide.selectSkuCode = value.skuCode;
                                          provide.selectSkuSpecs =
                                              value.skuSpecs;
                                          print(
                                              'skuSpecs================>>>>>=====> $selectSkuSpecs');
                                        });
                                      },
                                      child: Container(
                                        width: ScreenAdapter.width(680 / 4),
                                        height: ScreenAdapter.height(80),
                                        decoration: BoxDecoration(
                                            border:
                                                selectSkuSpecs == value.skuSpecs
                                                    ? Border.all(
                                                        color: Colors.black38,
                                                      )
                                                    : Border.all(
                                                        color: Colors.white)),
                                        // color: Colors.yellow,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: ScreenAdapter.height(80),
                                              width:
                                                  ScreenAdapter.width(128 / 3),
                                              child: Image.network(
                                                value.skuPic,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              //  width: ScreenAdapter.width(135),
                                              child: Text(
                                                value.skuSpecs,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.size(22)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()),
                            ),
                            Expanded(child: Container()),
                            Row(
                              children: <Widget>[
                                Expanded(child: Container()),
                                Icon(
                                  Icons.remove,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: ScreenAdapter.width(20),
                                ),
                                Text(
                                  '1',
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.size(30)),
                                ),
                                SizedBox(
                                  width: ScreenAdapter.width(20),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                                Expanded(child: Container()),
                                SizedBox(
                                  height: ScreenAdapter.height(20),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (selectSkuSpecs == null) {
                                  Fluttertoast.showToast(
                                      msg: '请选择颜色和尺码',
                                      gravity: ToastGravity.CENTER);
                                } else {
                                  Navigator.pop(
                                    context,
                                  );
                                }
                              },
                              child: Container(
                                width: ScreenAdapter.width(680),
                                height: ScreenAdapter.height(100),
                                child: Center(
                                  child: Container(
                                    width: ScreenAdapter.width(680),
                                    height: ScreenAdapter.height(80),
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        '确定',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenAdapter.size(30),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              );
            },
          );
        });
  }

  Provide<RegistrationInformationProvide> _setupEnd() {
    return Provide<RegistrationInformationProvide>(
      builder: (BuildContext context, Widget child,
          RegistrationInformationProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(80),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(50),
                ),
                Container(
                  width: ScreenAdapter.width(60),
                  height: ScreenAdapter.height(100),
                  child: Checkbox(
                    value: provide.groupValuea,
                    activeColor: Colors.black,
                    onChanged: (bool val) {
                      print(val);
                      provide.groupValuea = val;
                    },
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProtocolPage(
                          title: "innersect用户须知",
                          leading: true,
                        );
                      }));
                    },
                    child: Text('用户须知')),
              ],
            ),
            InkWell(
              onTap: () {
                var today = DateTime.now();
                print('today==>$today');
                print('today.str==>${today.toString()}');
                var date1 = today.microsecondsSinceEpoch;
                print('date1===>$date1');

                var date2 = DateTime.fromMillisecondsSinceEpoch(date1);
                print('date2===>$date2');
                if (provide.groupValuea == false) {
                  Fluttertoast.showToast(
                      msg: '请勾选用户须知', gravity: ToastGravity.CENTER);
                } else if (provide.userName == null) {
                  Fluttertoast.showToast(
                      msg: '请输入姓名', gravity: ToastGravity.CENTER);
                } else if (provide.certificate == null) {
                  Fluttertoast.showToast(
                      msg: '请输入证件号码', gravity: ToastGravity.CENTER);
                } else if (provide.phoneNumber == null) {
                  Fluttertoast.showToast(
                      msg: '请输入手机号码', gravity: ToastGravity.CENTER);
                } else {
                  if (provide.drawAwardType == 0) {
                    print('线上抽签');
                    if (provide.selectSkuSpecs == null) {
                      Fluttertoast.showToast(msg: '请选择尺码',gravity: ToastGravity.CENTER);
                    }else{
                        _showNetCallPhoneDialog();
                    }
                    
                  } else {
                    _showCallPhoneDialog();
                  }
                  // print('provide.draweeModel.drawAwardType========>${provide.draweeModel.drawAwardType}');
                }
              },
              child: Container(
                width: ScreenAdapter.width(695),
                height: ScreenAdapter.height(100),
                child: Center(
                  child: Container(
                    width: ScreenAdapter.width(695),
                    height: ScreenAdapter.height(90),
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        '提交',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  ///线下抽签提示
  void _showCallPhoneDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: ScreenAdapter.width(580),
              height: ScreenAdapter.height(720),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(580),
                    height: ScreenAdapter.height(130),
                    child: Center(
                      child: Text(
                        '确认登记信息',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(40),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decorationColor: Colors.white),
                      ),
                    ),
                  ),
                  provide.drawBySku == true
                      ? Container()
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Container(
                              child: Text(
                                '购买门店: ${provide.lotteryRegistrationPageModel.shopName}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  decorationColor: Colors.white,
                                  fontSize: ScreenAdapter.size(30),
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ],
                        ),
                  provide.drawBySku == true
                      ? Container()
                      : SizedBox(
                          height: ScreenAdapter.height(20),
                        ),
                  provide.drawBySku == true
                      ? Container()
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Container(
                              //   width: ScreenAdapter.width(500),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(180),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '门店地址:',
                                      //textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        decorationColor: Colors.white,
                                        fontSize: ScreenAdapter.size(30),
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenAdapter.width(400),
                                    height: ScreenAdapter.height(180),
                                    child: Text(
                                      '${provide.lotteryRegistrationPageModel.addr}',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        decorationColor: Colors.white,
                                        fontSize: ScreenAdapter.size(30),
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
                        child: Text(
                          '手机号码: ${provide.phoneNumber}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '姓名: ${provide.userName}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '证件号: ${provide.certificate}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '所选颜色/尺码: ${provide.selectSkuAndColor}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: ScreenAdapter.height(35),
                  // ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      if (provide.drawAwardType == 0) {
                        ///线上抽签
                        provide
                            .drawshopNet(
                                provide.selectSkuCode, provide.selectSkuSpecs)
                            .doOnListen(() {})
                            .doOnError((e, stack) {})
                            .doOnDone(() {})
                            .listen((items) {
                          print('items.data====>${items.data}');
                          if (items.data != null) {
                            provide.draweeModel =
                                DraweeModel.fromJson(items.data);
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, '/registrationSuccessfulPage',
                                arguments: {
                                  'draweeModel': provide.draweeModel,
                                  'longitude': provide.longitude,
                                  'latitude': provide.latitude,
                                });
                          }
                          print('items.message======>${items.message}');
                        });
                      } else {
                        provide
                            .drawshop()
                            .doOnListen(() {})
                            .doOnError((e, stack) {})
                            .doOnDone(() {})
                            .listen((items) {
                          print('items.data====>${items.data}');
                          if (items.data != null) {
                            if (provide.drawAwardType != 0) {
                              provide.draweeModel =
                                  DraweeModel.fromJson(items.data);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/registrationSuccessfulPage',
                                  arguments: {
                                    'draweeModel': provide.draweeModel,
                                    'longitude': provide.longitude,
                                    'latitude': provide.latitude
                                  });
                            } else {
                              provide.draweeModel =
                                  DraweeModel.fromJson(items.data);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/registrationSuccessfulPage',
                                  arguments: {
                                    'draweeModel': provide.draweeModel,
                                    'longitude': provide.longitude,
                                    'latitude': provide.latitude,
                                    'drawAwardType': provide.drawAwardType
                                  });
                            }
                          }
                          print('items.message======>${items.message}');
                        });
                      }
                    },
                    child: Container(
                      width: ScreenAdapter.width(530),
                      height: ScreenAdapter.height(90),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          '提交',
                          style: TextStyle(
                              color: Colors.white,
                              decorationColor: Colors.black,
                              fontSize: ScreenAdapter.size(30)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  )
                ],
              ),
            ),
          );
        });
  }

  ///线上抽签提示
  void _showNetCallPhoneDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: ScreenAdapter.width(580),
              height: ScreenAdapter.height(580),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(20), right: ScreenAdapter.width(20)),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.clear),
                    
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.width(580),
                    height: ScreenAdapter.height(50),
                    child: Center(
                      child: Text(
                        '登记信息',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(40),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            decorationColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  ),
                  provide.drawBySku == true
                      ? Container()
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Container(
                              child: Text(
                                '购买门店: ${provide.lotteryRegistrationPageModel.shopName}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  decorationColor: Colors.white,
                                  fontSize: ScreenAdapter.size(30),
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ],
                        ),
                  provide.drawBySku == true
                      ? Container()
                      : SizedBox(
                          height: ScreenAdapter.height(20),
                        ),
                  provide.drawBySku == true
                      ? Container()
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Container(
                              //   width: ScreenAdapter.width(500),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(180),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '门店地址:',
                                      //textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        decorationColor: Colors.white,
                                        fontSize: ScreenAdapter.size(30),
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenAdapter.width(400),
                                    height: ScreenAdapter.height(180),
                                    child: Text(
                                      '${provide.lotteryRegistrationPageModel.addr}',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        decorationColor: Colors.white,
                                        fontSize: ScreenAdapter.size(30),
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
                        child: Text(
                          '姓名: ${provide.userName}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '身份证号: ${provide.certificate}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '电话: ${provide.phoneNumber}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
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
                        child: Text(
                          '所选颜色/尺码: ${provide.selectSkuAndColor}',
                          style: TextStyle(
                            color: Colors.black54,
                            decorationColor: Colors.white,
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: ScreenAdapter.height(35),
                  // ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      if (provide.drawAwardType == 0) {
                        ///线上抽签
                        provide
                            .drawshopNet(
                                provide.selectSkuCode, provide.selectSkuSpecs)
                            .doOnListen(() {})
                            .doOnError((e, stack) {})
                            .doOnDone(() {})
                            .listen((items) {
                          print('items.data====>${items.data}');
                          if (items.data != null) {
                            provide.draweeModel =
                                DraweeModel.fromJson(items.data);
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, '/registrationSuccessfulPage',
                                arguments: {
                                  'draweeModel': provide.draweeModel,
                                  'longitude': provide.longitude,
                                  'latitude': provide.latitude,
                                  "endTime": provide.endTime,
                                });
                          }
                          print('items.message======>${items.message}');
                        });
                      } else {
                        provide
                            .drawshop()
                            .doOnListen(() {})
                            .doOnError((e, stack) {})
                            .doOnDone(() {})
                            .listen((items) {
                          print('items.data====>${items.data}');
                          if (items.data != null) {
                            if (provide.drawAwardType != 0) {
                              provide.draweeModel =
                                  DraweeModel.fromJson(items.data);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/registrationSuccessfulPage',
                                  arguments: {
                                    'draweeModel': provide.draweeModel,
                                    'longitude': provide.longitude,
                                    'latitude': provide.latitude
                                  });
                            } else {
                              provide.draweeModel =
                                  DraweeModel.fromJson(items.data);
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, '/registrationSuccessfulPage',
                                  arguments: {
                                    'draweeModel': provide.draweeModel,
                                    'longitude': provide.longitude,
                                    'latitude': provide.latitude,
                                    'drawAwardType': provide.drawAwardType
                                  });
                            }
                          }
                          print('items.message======>${items.message}');
                        });
                      }
                    },
                    child: Container(
                      width: ScreenAdapter.width(530),
                      height: ScreenAdapter.height(90),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          '提交',
                          style: TextStyle(
                              color: Colors.white,
                              decorationColor: Colors.black,
                              fontSize: ScreenAdapter.size(30)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  )
                ],
              ),
            ),
          );
        });
  }
}
