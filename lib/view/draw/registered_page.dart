import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/registered_provide.dart';

import 'package:provide/provide.dart';

///查看登记
class DrawRegisteredPage extends PageProvideNode {
  final DrawRegisteredProvide _provide = DrawRegisteredProvide();
  DrawRegisteredPage() {
    mProviders.provide(Provider<DrawRegisteredProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return DrawRegisteredContentPage(_provide);
  }
}

class DrawRegisteredContentPage extends StatefulWidget {
  final DrawRegisteredProvide provide;
  DrawRegisteredContentPage(this.provide);
  @override
  _DrawRegisteredContentPageState createState() =>
      _DrawRegisteredContentPageState();
}

class _DrawRegisteredContentPageState extends State<DrawRegisteredContentPage> {
  DrawRegisteredProvide provide;
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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

  Provide<DrawRegisteredProvide> _setupHead() {
    return Provide<DrawRegisteredProvide>(
      builder:
          (BuildContext context, Widget child, DrawRegisteredProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(400),
          child: Center(
            child: Container(
              width: ScreenAdapter.width(695),
              height: ScreenAdapter.height(365),
              child: Image.asset(
                'assets/images/chouqian.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Provide<DrawRegisteredProvide> _setupBody() {
    return Provide<DrawRegisteredProvide>(
      builder:
          (BuildContext context, Widget child, DrawRegisteredProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(560),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenAdapter.height(50),
              ),
              Center(
                child: Text(
                  'Nike Air Fear of God 180',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(40),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  '抽签资格',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(40),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '北京    |   ￥1199',
                  style: TextStyle(
                      color: Color.fromRGBO(167, 166, 171, 1.0),
                      fontSize: ScreenAdapter.size(30),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Center(
                child: Text(
                  '12月30日  18:00  截止登记',
                  style: TextStyle(
                      fontSize: ScreenAdapter.size(30),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(70),
              ),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black12,
                ),
              ),
              Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(170),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(50),
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
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '登记信息',
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
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '等待结果',
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
                                  color: Color.fromRGBO(202, 202, 202, 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenAdapter.width(10)))),
                              child: Center(
                                child: Container(
                                  width: ScreenAdapter.width(8),
                                  height: ScreenAdapter.width(8),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(152, 152, 160, 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenAdapter.width(10)))),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(10),
                            ),
                            Text(
                              'STEP 1',
                              style: TextStyle(
                                  color: Color.fromRGBO(150, 150, 150, 1.0)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenAdapter.height(10),
                        ),
                        Text(
                          '线下够买',
                          style: TextStyle(
                              color: Color.fromRGBO(150, 150, 150, 1.0),
                              fontSize: ScreenAdapter.size(30)),
                        )
                      ],
                    ),
                    SizedBox(
                      width: ScreenAdapter.height(70),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: ScreenAdapter.width(680),
                  height: ScreenAdapter.height(1),
                  color: Colors.black12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<DrawRegisteredProvide> _setupEnd() {
    return Provide<DrawRegisteredProvide>(
      builder:
          (BuildContext context, Widget child, DrawRegisteredProvide provide) {
        return Column(
          children: <Widget>[
            Center(
              child: Container(
                width: ScreenAdapter.width(680),
                height: ScreenAdapter.height(268),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenAdapter.height(48),
                    ),
                    Container(
                      child: Text(
                        '中奖名单',
                        style: TextStyle(fontSize: ScreenAdapter.size(30)),
                      ),
                    ),
                    Center(
                      child: Text(
                        '敬请期待',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(35),
                            color: Color.fromRGBO(150, 150, 150, 1.0)),
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
                color: Colors.black12,
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(48),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '活动规则',
                style: TextStyle(fontSize: ScreenAdapter.size(35)),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(48),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '本次发售以二次抽签方式进行',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '本次发售由JUICE北京/JUICE城都联合INNERSECT',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                'APP共同发售Nike Air Fear of God 180 「Black」',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '拥有INNERSECT APP账号即可参与第一轮线上登记',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '抽签',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '登记方式:',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '下载INNERSECT APP, 按照步骤填写指定信息',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '注册INNERSECT APP账号后才可于指定通道进入',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '第一轮抽签预约',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
             SizedBox(
              height: ScreenAdapter.height(40),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '第一轮APP登记抽签时间:5月16日16：00-18：00',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
            Container(
              width: ScreenAdapter.width(680),
              child: Text(
                '(限北京/成都地区参与)',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(30),
                    color: Color.fromRGBO(150, 150, 150, 1.0)),
              ),
            ),
             SizedBox(
              height: ScreenAdapter.height(40),
            ),
            Container(
              width: ScreenAdapter.width(690),
              height: ScreenAdapter.height(90),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87),
              ),
              child: Center(
                child: Text('已登记',style: TextStyle(fontSize: ScreenAdapter.size(30),fontWeight: FontWeight.w800),),
              ),
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
