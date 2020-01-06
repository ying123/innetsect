import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/registration_information_provide.dart';
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
    print('登记信息');
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
                Text(
                  '请填写您的真实身份信息以用于进行抽签,并确保',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(28),
                      color: Color.fromRGBO(84, 84, 84, 1.0)),
                ),
                Text('注册手机号能够正常使用',
                    style: TextStyle(
                        fontSize: ScreenAdapter.size(28),
                        color: Color.fromRGBO(84, 84, 84, 1.0))),
                Text('如中签后因信息核实不正确，手机无法正常通信等',
                    style: TextStyle(
                        fontSize: ScreenAdapter.size(28),
                        color: Color.fromRGBO(84, 84, 84, 1.0))),
                Text('个人原因,INNERSECT将有权取消您的中签资格',
                    style: TextStyle(
                        fontSize: ScreenAdapter.size(28),
                        color: Color.fromRGBO(84, 84, 84, 1.0))),
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
            )
          ],
        );
      },
    );
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
                Text('用户须知'),
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
                  _showCallPhoneDialog();
                }
              },
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
            )
          ],
        );
      },
    );
  }

  void _showCallPhoneDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: ScreenAdapter.width(580),
              height: ScreenAdapter.height(560),
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
                  Row(
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
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: ScreenAdapter.width(40),
                      ),
                      Container(
                        //width: ScreenAdapter.width(500),
                        child: Container(
                            child: Row(
                          children: <Widget>[
                            Container(
                              height: ScreenAdapter.height(70),
                              child: Text(
                                '门店地址:',
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
                              height: ScreenAdapter.height(60),
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
                    height: ScreenAdapter.height(35),
                  ),
                  GestureDetector(
                    onTap: () {
                      provide
                          .drawshop()
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
                              arguments: {'draweeModel': provide.draweeModel});
                        }
                        print('items.message======>${items.message}');
                      });
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
