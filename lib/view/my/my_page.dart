import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/binding_sign_in/binding_sign_in_page.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/my/exhibition/lucky_sign_page.dart';
import 'package:innetsect/view/my/feedback/feedback_page.dart';
import 'package:innetsect/view/my/notice/notice_page.dart';
import 'package:innetsect/view/my/settings/my_settings_page.dart';
import 'package:innetsect/view/my/vip_card/vip_card_page.dart';
import 'package:innetsect/view/my_order/after_service_page.dart';
import 'package:innetsect/view/my_order/my_order_page.dart';

import 'package:innetsect/view/personal_center/personal_center_page.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/my/my_provide.dart';
import 'package:provide/provide.dart';

///我的页面
class MyPage extends PageProvideNode {
  final MyProvide _provide = MyProvide();
  final LoginProvide _loginProvide = LoginProvide.instance;
  final String page;
  MyPage({this.page}) {
    mProviders.provide(Provider<MyProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return MyContentPage(_provide,_loginProvide,page);
  }
}

class MyContentPage extends StatefulWidget {
  final MyProvide provide;
  final LoginProvide _loginProvide;
  final String page;
  MyContentPage(this.provide,this._loginProvide,this.page);
  @override
  _MyContentPageState createState() => _MyContentPageState();
}

class _MyContentPageState extends State<MyContentPage> {
  LoginProvide _loginProvide;
  String page;
  @override
  void initState() {
    super.initState();

    this._loginProvide??=widget._loginProvide;
    page = widget.page;
    _loginProvide.pages = widget.page;
  }



//  Future _loginPage() async {
//    print('_loginPage');
//    Navigator.pushNamed(context, '/loginPage');
//  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: 1,
        itemBuilder: (BuildContext context, int index){
          return new Column(
            children: <Widget>[
              _setupHeader(),
              SizedBox(
                height: ScreenAdapter.height(40),
              ),
              _setupCenter(),
              page=="exhibition"?
                  _exhibitionAction():Container(width: 0,height: 0,),
              _setupBoady(),
            ],
          );
        },
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
                  InkWell(
                    onTap: () {
                      // 购物车
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return CommodityCartPage();
                          },settings: RouteSettings(arguments: {'isBack': true,'page':page})
                      ));
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
                  InkWell(
                    onTap: () {
                      print('我的订单被点击');
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return MyOrderPage();
                        }
                      ));
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
                  InkWell(
                    onTap: () {
                      print('地址管理被点击');
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return AddressManagementPage();
                          }
                      ));
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
                  InkWell(
                    onTap: () {
                      // 我的售后
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return AfterServicePage();
                        }
                      ));
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
                    InkWell(
                      onTap: () {
                        print('贵宾卡');
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context){
                            return VIPCardPage();
                          }
                        ));
                      },
                      child: _setupBtn(
                          'assets/images/newpersonalcentre/我的卡券@2x.png',
                          '贵宾卡',
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


  /// 展会操作
  Widget _exhibitionAction(){
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
              InkWell(
                onTap: () {
                  // 我的门票

                },
                child: _setupBtn(
                    'assets/images/user/my_ticket@3x.png',
                    '我的门票',
                    36.0,
                    39.0),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return BindingSignInPage();
                    }
                  ));
                },
                child: _setupBtn(
                    'assets/images/user/my_scan@3x.png',
                    '扫码签到',
                    35.0,
                    40.0),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: () {
                },
                child: _setupBtn(
                    'assets/images/user/my_ordered@3x.png',
                    '我的预约',
                    31,
                    39),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: () {
                  ///跳转我的中签
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return LuckySignPage();
                    }
                  ));
                },
                child: _setupBtn(
                    'assets/images/user/my_ordered@3x.png',
                    '我的中签',
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
      ],
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
            CustomsWidget().listSlider(
              icon: 'assets/images/newpersonalcentre/购买须知@2x.png',
              title: '购买须知',
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return NoticePage();
                    }
                  ));
              }
            ),
            new Divider(color: Colors.grey,endIndent: 20,indent: 20,height: 3,),
            CustomsWidget().listSlider(icon: 'assets/images/newpersonalcentre/联系客服@2x.png', title: '联系客服'),
            new Divider(color: Colors.grey,endIndent: 20,indent: 20,height: 3,),
            CustomsWidget().listSlider(icon: 'assets/images/newpersonalcentre/反馈意@2x.png',
                title: '反馈意见',onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return FeedBackPage();
                }
              ));
                }),
            new Divider(color: Colors.grey,endIndent: 20,indent: 20,height: 3,),
          ],
        ));
      },
    );
  }

  Provide<LoginProvide> _setupHeader() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        UserInfoModel userModel = provide.userInfoModel;
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(480),
              color: Colors.white,
              child: Image.asset(
                'assets/images/user/header.png',
                fit: BoxFit.fill,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(435),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenAdapter.height(57),
                  left: ScreenAdapter.width(680)),
              child: InkWell(
                onTap: () {
                  print('设置按钮被点击');
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return MySettingsPage(page:page);
                    }
                  ));
                },
                child: Image.asset(
                  'assets/images/mall/setting.png',
                  fit: BoxFit.cover,
                  width: ScreenAdapter.width(50),
                  height: ScreenAdapter.width(50),
                ),
              ),
            ),
///TODO 暂时隐藏
//            Padding(
//              padding: EdgeInsets.only(
//                  top: ScreenAdapter.height(57), left: ScreenAdapter.width(35)),
//              child: Container(
//                width: ScreenAdapter.width(55),
//                height: ScreenAdapter.height(45),
//                child: Image.asset(
//                  'assets/images/newpersonalcentre/消息@1x.png',
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(170)),
              child: Center(
                child: Text(
                  userModel!=null?userModel.nickName:'',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenAdapter.size(35),
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(278), 0, 0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    print('个人中心被点击');
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return PersonalCenterPage();
                      }
                    ));
                  },
                  child: Container(
                    width: ScreenAdapter.width(190),
                    height: ScreenAdapter.width(190),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      //border: Border.all(color: Colors.black12),
                    ),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: userModel!=null&&userModel.portrait!=null?
                         NetworkImage( userModel.portrait):AssetImage(
                         "assets/images/mall/hot_brand1.png", ),
                    ) ,
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
