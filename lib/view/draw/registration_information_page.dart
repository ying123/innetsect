import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/registration_information_provide.dart';
import 'package:provide/provide.dart';

///登记信息
class RegistrationInformationPage extends PageProvideNode {
  final RegistrationInformationProvide _provide =
      RegistrationInformationProvide();
  RegistrationInformationPage() {
    mProviders
        .provide(Provider<RegistrationInformationProvide>.value(_provide));
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
                  onChanged: (str) {},
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
                  onChanged: (str) {},
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
                  '手机号码+86',
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
                      hintText: '请输入手机号码',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none
                      // contentPadding: EdgeInsets.all(0)
                      ),
                  onChanged: (str) {},
                ),
              ),
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
                _showCallPhoneDialog('13718220555');
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

  void _showCallPhoneDialog(String phone) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: ScreenAdapter.width(580),
              height: ScreenAdapter.width(480),
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
                          '手机号: 15865894784',
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
                          '姓名: 颜佳琪',
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
                          '身份证号: 310118954878474481',
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
                          '购买城市: 上海',
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
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/registrationSuccessfulPage');
                      
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
                            fontSize: ScreenAdapter.size(30)
                          ),
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
