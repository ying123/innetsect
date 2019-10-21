import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/animation_util.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my_order/my_order_page.dart';


import 'package:innetsect/view/personal_center/personal_center_page.dart';
import 'package:innetsect/view_model/my/my_provide.dart';
import 'package:provide/provide.dart';

///我的页面
class MyPage extends PageProvideNode {
  final MyProvide _provide = MyProvide();
  MyPage() {
    mProviders.provide(Provider<MyProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return MyContentPage(_provide);
  }
}

class MyContentPage extends StatefulWidget {
  final MyProvide provide;
  MyContentPage(this.provide);
  @override
  _MyContentPageState createState() => _MyContentPageState();
}

class _MyContentPageState extends State<MyContentPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: <Widget>[
          _setupHeader(),
          SizedBox(
            height: ScreenAdapter.height(40),
          ),
          _setupCenter(),
          _setupBoady(),
        ],
      ),
    ));
  }

  Provide<MyProvide> _setupCenter() {
    return Provide<MyProvide>(
      builder: (BuildContext context, Widget child, MyProvide provide) {
        return Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(150),
              //color: Colors.blue,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('购物车被点击');
                    },
                    child: _setupBtn(
                        'assets/images/newpersonalcentre/购物车@2x.png',
                        '购物车',
                        36.0,
                        39.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('我的订单被点击');
                      Navigator.of(context).push(CommonUtil.createRoute(AnimationUtil.getBottominAnilmation(), MyOrderPage()));
                    },
                    child: _setupBtn(
                        'assets/images/newpersonalcentre/我的订单@2x.png',
                        '我的订单',
                        35.0,
                        40.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('地址管理被点击');
                    },
                    child: _setupBtn(
                        'assets/images/newpersonalcentre/地址管理@2x.png',
                        '地址管理',
                        31,
                        39),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('我的售后被点击');
                    },
                    child: _setupBtn(
                        'assets/images/newpersonalcentre/我的售后@2x.png',
                        '我的售后',
                        37,
                        39),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(10),
              color: Color.fromRGBO(249, 249, 249, 1.0),
            ),
            Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(150),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenAdapter.width(50),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('我的卡卷被点击');
                      },
                      child: _setupBtn(
                          'assets/images/newpersonalcentre/我的卡券@2x.png',
                          '我的卡卷',
                          44.0,
                          40.0),
                    ),
                  ],
                )),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(10),
              color: Color.fromRGBO(249, 249, 249, 1.0),
            ),
          ],
        );
      },
    );
  }

  Provide<MyProvide> _setupBtn(
      String imagePath, String text, double width, double height) {
    return Provide<MyProvide>(
      builder: (BuildContext context, Widget child, MyProvide provide) {
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(110),
              height: ScreenAdapter.height(105),
              //color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    imagePath,
                    width: ScreenAdapter.width(width),
                    height: ScreenAdapter.height(height),
                    fit: BoxFit.fill,
                  )),
                  SizedBox(
                    height: ScreenAdapter.height(20),
                  ),
                  Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Color.fromRGBO(95, 95, 95, 1.0),
                          fontSize: ScreenAdapter.size(27)),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Provide<MyProvide> _setupBoady() {
    return Provide<MyProvide>(
      builder: (BuildContext context, Widget child, MyProvide provide) {
        return Container(
            child: Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(40),
                      height: ScreenAdapter.width(26),
                      child: Image.asset('assets/images/newpersonalcentre/展会@2x.png',fit: BoxFit.fill,),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                     '展会',
                      style: TextStyle(
                        color: Color.fromRGBO(95, 95, 95, 1.0),
                        fontSize: ScreenAdapter.size(27),

                        //fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    'assets/images/mall/arrow_right.png',
                    width: ScreenAdapter.width(25),
                    height: ScreenAdapter.width(25),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(43),
                  ),
                ],
              ),
            ),
           Container(
             margin: EdgeInsets.only(left: ScreenAdapter.width(50),right: ScreenAdapter.width(50)),
             width: ScreenAdapter.width(750),
             height: ScreenAdapter.height(3),
             color: Color.fromRGBO(249, 249, 249, 1.0),
           ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(43),
                      height: ScreenAdapter.height(33),
                      child: Image.asset('assets/images/newpersonalcentre/购买须知@2x.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      '够买须知',
                      style: TextStyle(
                        color: Color.fromRGBO(95, 95, 95, 1.0),
                        fontSize: ScreenAdapter.size(27),
              
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    'assets/images/mall/arrow_right.png',
                    width: ScreenAdapter.width(25),
                    height: ScreenAdapter.width(25),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(43),
                  ),
                ],
              ),
            ),
           Container(
             margin: EdgeInsets.only(left: ScreenAdapter.width(50),right: ScreenAdapter.width(50)),
             width: ScreenAdapter.width(750),
             height: ScreenAdapter.height(3),
             color: Color.fromRGBO(249, 249, 249, 1.0),
           ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(35),
                      height: ScreenAdapter.height(29),
                      child: Image.asset('assets/images/newpersonalcentre/联系客服@2x.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                     '联系客服',
                      style: TextStyle(
                        color: Color.fromRGBO(95, 95, 95, 1.0),
                        fontSize: ScreenAdapter.size(27),
                       
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    'assets/images/mall/arrow_right.png',
                    width: ScreenAdapter.width(25),
                    height: ScreenAdapter.width(25),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(43),
                  ),
                ],
              ),
            ),
           Container(
             margin: EdgeInsets.only(left: ScreenAdapter.width(50),right: ScreenAdapter.width(50)),
             width: ScreenAdapter.width(750),
             height: ScreenAdapter.height(3),
             color: Color.fromRGBO(249, 249, 249, 1.0),
           ),
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(50),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(37),
                      height: ScreenAdapter.height(29),
                      child: Image.asset('assets/images/newpersonalcentre/反馈意@2x.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      '反馈意见',
                      style: TextStyle(
                        color: Color.fromRGBO(95, 95, 95, 1.0),
                        fontSize: ScreenAdapter.size(27),
                     
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    'assets/images/mall/arrow_right.png',
                    width: ScreenAdapter.width(25),
                    height: ScreenAdapter.width(25),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(43),
                  ),
                ],
              ),
            ),
           Container(
             margin: EdgeInsets.only(left: ScreenAdapter.width(50),right: ScreenAdapter.width(50)),
             width: ScreenAdapter.width(750),
             height: ScreenAdapter.height(3),
             color: Color.fromRGBO(249, 249, 249, 1.0),
           ),
          
          ],
        ));
      },
    );
  }

  Provide<MyProvide> _setupHeader() {
    return Provide<MyProvide>(
      builder: (BuildContext context, Widget child, MyProvide provide) {
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(435),
              color: Colors.white,
              child: Image.asset(
                'assets/images/我的页面背景图.png',
                fit: BoxFit.fill,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(435),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(57),
                  left: ScreenAdapter.width(680)),
              child: Image.asset(
                'assets/images/mall/setting.png',
                fit: BoxFit.cover,
                width: ScreenAdapter.width(50),
                height: ScreenAdapter.width(50),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(57), left: ScreenAdapter.width(35)),
              child: Container(
                width: ScreenAdapter.width(55),
                height: ScreenAdapter.height(45),
                child: Image.asset(
                  'assets/images/newpersonalcentre/消息@1x.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(170)),
              child: Center(
                child: Text(
                  provide.mobilePhoneNumber,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenAdapter.size(35),
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(278), 0, 0),
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    print('个人中心被点击');
                   Navigator.of(context).push(CommonUtil.createRoute(
                            AnimationUtil.getBottominAnilmation(),
                            PersonalCenterPage()));  
                  },
                  child: Container(
                    width: ScreenAdapter.width(190),
                    height: ScreenAdapter.width(190),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenAdapter.width(100))),
                      //border: Border.all(color: Colors.black12),
                    ),
                    child: Image.asset(
                      provide.headPortrait,
                      fit: BoxFit.cover,
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
}
