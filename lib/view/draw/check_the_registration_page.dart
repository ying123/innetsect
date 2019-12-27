import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/check_the_registration_provide.dart';
import 'package:provide/provide.dart';

class CheckTheRegistrationPage extends PageProvideNode {
  final CheckTheRegistrationProvide _provide = CheckTheRegistrationProvide();
  CheckTheRegistrationPage() {
    mProviders.provide(Provider<CheckTheRegistrationProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return CheckTheRegistrationContentPage(_provide);
  }
}

class CheckTheRegistrationContentPage extends StatefulWidget {
  final CheckTheRegistrationProvide provide;
  CheckTheRegistrationContentPage(this.provide);
  @override
  _CheckTheRegistrationContentPageState createState() =>
      _CheckTheRegistrationContentPageState();
}

class _CheckTheRegistrationContentPageState
    extends State<CheckTheRegistrationContentPage> {
  CheckTheRegistrationProvide provide;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
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
      body: Column(
        children: <Widget>[
          _setupHead(),
          Container(
            width: ScreenAdapter.width(690),
            height: ScreenAdapter.height(1),
            color: Colors.black12,
          ),
          SizedBox(
            height: ScreenAdapter.height(20),
          ),
          _setupBody(),

          _setupEnd(),
        ],
      ),
    );
  }

  Provide<CheckTheRegistrationProvide> _setupHead() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(300),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(30),
                  ),
                  Container(
                    width: ScreenAdapter.width(210),
                    height: ScreenAdapter.height(210),
                    child: Image.asset(
                      'assets/images/chouqian.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(40),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(400),
                        child: Text(
                          'Nike Air Fear of God 180',
                          style: TextStyle(
                              fontSize: ScreenAdapter.size(30),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(10),
                      ),
                      Container(
                        width: ScreenAdapter.width(400),
                        child: Text(
                          '抽签资格',
                          style: TextStyle(
                              fontSize: ScreenAdapter.size(30),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(30),
                      ),
                      Container(
                        width: ScreenAdapter.width(400),
                        child: Text(
                          '北京   |   ￥1198',
                          style: TextStyle(
                              fontSize: ScreenAdapter.size(30),
                              color: Color.fromRGBO(160, 160, 160, 1.0),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(540),
              top: ScreenAdapter.height(120),
              child: Image.asset(
                'assets/images/zhongqian.jpg',
                width: ScreenAdapter.width(170),
                height: ScreenAdapter.height(170),
              ),
            ),
          ],
        );
      },
    );
  }

  Provide<CheckTheRegistrationProvide> _setupBody() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
        return Column(
          children: <Widget>[
            Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(65),
                child: Row(
                  children: <Widget>[
                    Text(
                      '身份证: ',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    Text(
                      '3101131215****0523',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),

                  ],
                )),
                SizedBox(
                  height: ScreenAdapter.height(30),
                ),
            Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(65),
                child: Row(
                  children: <Widget>[
                    Text(
                      '购买城市: ',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    Text(
                      '上海',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),

                  ],
                )),
                SizedBox(
                  height: ScreenAdapter.height(30),
                ),
            Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(65),
                child: Row(
                  children: <Widget>[
                    Text(
                      '手机号: ',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    Text(
                      '18516005100',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),

                  ],
                )),
                SizedBox(
                  height: ScreenAdapter.height(30),
                ),
            Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(65),
                child: Row(
                  children: <Widget>[
                    Text(
                      '预约开始时间: ',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(

                      ),
                    ),
                    Text(
                      '2019-12-18   09:00:00',
                      style: TextStyle(fontSize: ScreenAdapter.size(30),color: Colors.black54),
                    ),

                  ],
                )),
          ],
        );
      },
    );
  }

  Provide<CheckTheRegistrationProvide> _setupEnd() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(400),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                color: Colors.black,
                child: Center(
                  child: Text('返回',style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenAdapter.size(30),
                    fontWeight: FontWeight.w800
                  ),),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
