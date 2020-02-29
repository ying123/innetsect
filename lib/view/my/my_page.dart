import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/binding_sign_in/binding_sign_in_page.dart';
import 'package:innetsect/view/mall/commodity/qimo_page.dart';
import 'package:innetsect/view/my/activity/activity_mark_page.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/my/allocating/allocating_page.dart';
import 'package:innetsect/view/my/allocating/allocating_record_page.dart';
import 'package:innetsect/view/my/exhibition/lucky_sign_page.dart';
import 'package:innetsect/view/my/feedback/feedback_page.dart';
import 'package:innetsect/view/my/notice/notice_page.dart';
import 'package:innetsect/view/my/settings/my_settings_page.dart';
import 'package:innetsect/view/my/tickets/tickets_page.dart';
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
              _allocatingAction(),
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
                     SizedBox(
                      width: ScreenAdapter.width(50),
                    ),
                    InkWell(
                      onTap: () {
                        print('我的抽签');
                       Navigator.pushNamed(context, '/myDrawPage');
                      },
                      child: _setupBtn(
                          'assets/images/my_ordered@3x.png',
                          '我的抽签',
                          44.0,
                          40.0),
                    ),
                     SizedBox(
                      width: ScreenAdapter.width(50),
                    ),
                   // 优惠卷
                    InkWell(
                      onTap: () {
                        print('优惠卷');
                       Navigator.pushNamed(context, '/myCouponsPage');
                      },
                      child: _setupBtn(
                          'assets/images/my_ordered@3x.png',
                          '优惠卷',
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return TicketsPage();
                    }
                  ));
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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ActivityMarkPage();
                    }
                  ));
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

  /// 调货操作
  Widget _allocatingAction(){
    dynamic model = UserTools().getUserData();
    if(model!=null&&model['acct_type']==10){
      return Column(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(150),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // 调货
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return AllocatingPage();
                        })
                    );
                  },
                  child: _setupBtn(
                      'assets/images/mall/exhibition.png',
                      '调货',
                      36.0,
                      39.0),
                ),
                InkWell(
                  onTap: () {
                    UserInfoModel models = _loginProvide.userInfoModel;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return AllocatingRecordPage(mobile:models.mobile);
                      }
                    ));
                  },
                  child: _setupBtn(
                      'assets/images/mall/exhibition.png',
                      '调货记录',
                      35.0,
                      40.0),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(10),
            color: Color.fromRGBO(249, 249, 249, 1.0),
          )
        ],
      );
    }else{
      return Container(width: 0,height: 0,);
    }
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
                    fit: BoxFit.contain,
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
            CustomsWidget().listSlider(icon: 'assets/images/newpersonalcentre/联系客服@2x.png',
                title: '联系客服',onTap: (){
                  UserInfoModel userInfoModel = UserTools().getUserInfo();
                  // 数据结构组装
                  var json={
                    "nickName": userInfoModel.nickName==null?userInfoModel.mobile:userInfoModel.nickName,
                    "peerId":"10052522",
                  };
                  var otherParams = jsonEncode(json);
                  // 用户id
                  var clientId = "1000${userInfoModel.acctID}";
                  // 自定义字段
                  var userInfo={
                    "手机号":userInfoModel.mobile
                  };

                  var qimoPath = "https://webchat.7moor.com/wapchat.html?accessId=20ed0990-2268-11ea-a2c3-49801d5a0f66"
                      +"&fromUrl=m3.innersect.net&urlTitle=innersect"
                      +"&otherParams="+Uri.encodeFull(otherParams)+"&clientId="+clientId+"&customField="+Uri.encodeFull(jsonEncode(userInfo));
                  print(qimoPath);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return QimoPage(url: qimoPath,);
                      }
                  ));
                }),
            new Divider(color: Colors.grey,endIndent: 20,indent: 20,height: 3,),
            CustomsWidget().listSlider(icon: 'assets/images/newpersonalcentre/反馈意@2x.png',
                title: '反馈意见',onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return FeedBackPage();
                }
              ));
                }),
            // new Divider(color: Colors.grey,endIndent: 20,indent: 20,height: 3,),
            // CustomsWidget().listSlider(icon: 'assets/images/newpersonalcentre/反馈意@2x.png',
            //     title: '账户与安全',onTap: (){
            //   Navigator.pushNamed(context, '/accountCancellationPage');
            //     }
            //     ),
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
