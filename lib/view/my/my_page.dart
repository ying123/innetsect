import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
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
       // shrinkWrap: true,
        //physics: //FixedExtentScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: <Widget>[
          _setupHeader(),
          _setupBoady(),
        ],
      ),
    ));
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
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.myOrder,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.shoppingCart,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.addressManagement,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.showTickets,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.carJ,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.afterSales,
                      style: TextStyle(
                       color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.shoppingKnow,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(125),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(53),
                  ),
                  Center(
                    child: Container(
                      width: ScreenAdapter.width(50),
                      height: ScreenAdapter.width(50),
                      child: Image.asset('assets/images/品牌.png'),
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Center(
                    child: Text(
                      provide.customerService,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 32, 32, 0.9),
                        fontSize: ScreenAdapter.size(35),
                        fontWeight: FontWeight.w600,
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
              height: ScreenAdapter.height(580),
              color: Colors.white,
              child: Image.asset(
                'assets/images/我的页面背景图.png',
                fit: BoxFit.cover,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(525),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(55),
                  left: ScreenAdapter.width(638)),
              child: Image.asset(
                'assets/images/mall/setting.png',
                fit: BoxFit.cover,
                width: ScreenAdapter.width(70),
                height: ScreenAdapter.height(70),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(266)),
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
              padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(378), 0, 0),
              child: Center(
                child: Container(
                  width: ScreenAdapter.width(200),
                  height: ScreenAdapter.width(200),
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
            )
          ],
        );
      },
    );
  }
}
