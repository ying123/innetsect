import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';
import 'dart:async';

class LoginPage extends PageProvideNode {
  final LoginProvide _provide = LoginProvide();
  LoginPage() {
    mProviders.provide(Provider<LoginProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return LoginContentPage();
  }
}

class LoginContentPage extends StatefulWidget {
  @override
  _LoginContentPageState createState() => _LoginContentPageState();
}

class _LoginContentPageState extends State<LoginContentPage> {
  String pages;
  // 是否验证码登录
  bool isPhone = false;
  // 验证码
  bool isButtonEnable = true;
  ///倒计时定时器
  Timer timer;
  int count = 60;
  String buttonText="获取验证码";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              // 返回按钮
              Navigator.pop(context);
              if(pages == 'orderDetail'){
                Navigator.pop(context);
              }
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _setupLogo(),
            SizedBox(
              height: ScreenAdapter.height(100),
            ),
            setupTextFields(),
            _setupVerificationCodeBtn(),
             SizedBox(
              height: ScreenAdapter.height(20),
            ),
            _setupLoginBtn(),
            _setupRegisteredBtn(),
             SizedBox(
              height: ScreenAdapter.height(60),
            ),
            _setupThirdPartyBtn(),
          ],
        ),
      ),
    );
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      // 运用未来获取context，初始化数据
      Map<dynamic,dynamic> mapData = ModalRoute.of(context).settings.arguments;
      if(mapData!=null){
        pages = mapData['pages'];
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  Provide<LoginProvide> _setupLogo() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return Image.asset(
          provide.loginImage,
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(200),
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget setupTextFields() {
    return new Column(
      children: _setupContent(),
    );
  }

  List<Provide<LoginProvide>> _setupContent() {
    return new List<Provide<LoginProvide>>.generate(
        2, (int index) => _setupItem(index));
  }

  Provide<LoginProvide> _setupItem(int index) {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return Container(
          margin: EdgeInsets.fromLTRB(
              ScreenAdapter.width(70), 0, ScreenAdapter.width(70), 0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Stack(
                      children: <Widget>[
                        isPhone ?
                        new TextField(
                          enabled: true,
                          style: new TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: provide.placePhoneText[index],
                            hintStyle: new TextStyle(color: Colors.grey),
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (str) {
                            if (index == 0) {
                              provide.userCode = str;
                            }
                            if (index == 1) {
                              provide.vaildCode = str;
                            }
                          },
                        ):new TextField(
                          enabled: true,
                          obscureText:
                          (index == 1 && provide.passwordVisiable == false)
                              ? true
                              : false,
                          style: new TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: provide.placeHoderText[index],
                            hintStyle: new TextStyle(color: Colors.grey),
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (str) {
                            if (index == 0) {
                              provide.userCode = str;
                            }
                            if (index == 1) {
                              provide.passwordVisiable = false;
                              provide.password = str;
                            }
                          },
                        ),
                        isPhone && index ==1?
                            new Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: ScreenAdapter.width(220),
                                height: ScreenAdapter.height(60),
                                child: FlatButton(
                                  disabledColor: Colors.grey.withOpacity(0.1),
                                  disabledTextColor: Colors.white,
                                  textColor: isButtonEnable ? Colors.white : Colors.white,
                                  color: isButtonEnable
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.8),
                                  onPressed: () {
                                    _buttonClickListen(provide);
                                  },
                                  child: Text(
                                    buttonText,
                                    style: TextStyle(fontSize: ScreenAdapter.size(22)),
                                  ),
                                ),
                              ))
                            :new Text("")
                      ],
                    ),
                  ),
                ],
              ),
              new Divider(
                height: 1,
                color: Color(0xFFdddddd),
              )
            ],
          ),
        );
      },
    );
  }

  void  _buttonClickListen(LoginProvide provide) {
    if (isButtonEnable) {
      print('获取验证码');
      provide.getVaildCode().doOnListen(() {
        print('doOnListen');
      })
          .doOnCancel(() {})
          .listen((item) {
        ///加载数据
        print('listen data->$item');
//      _provide
      }, onError: (e) {});

      setState(() {
        isButtonEnable = false;
      });
      _initTimer();
      return null;
    } else {
      return null;
    }
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;

      if (count == 0) {
        timer.cancel();
        setState(() {
          isButtonEnable = true;
          count = 60;
          buttonText = '获取验证码';
        });
      } else {
        setState(() {
          buttonText = '重新发送(${count})';
        });
      }
    });
  }

  ///设置验证码按钮
  Provide<LoginProvide> _setupVerificationCodeBtn() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return InkWell(
          onTap: (){
            setState(() {
              isPhone = !isPhone;
            });
          },
          child: Container(
            alignment: Alignment.centerRight,
            height: ScreenAdapter.height(95),
            width: ScreenAdapter.width(595),
            child: Text(
              !isPhone?'验证码登录':'密码登录',
              style: TextStyle(
                  color: Colors.black, fontSize: ScreenAdapter.size(30)),
            ),
          ),
        );
      },
    );
  }

  ///设置登入按钮
  Provide<LoginProvide> _setupLoginBtn() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return InkWell(
          onTap: (){
            // 登录
            provide.loginData()
                .doOnListen(() {
              print('doOnListen');
            })
                .doOnCancel(() {})
                .listen((item) {
              print('listen data->$item');
              ///加载数据
              if(item.data!=null){
                /// 获取用户信息
                provide.getUserInfo(context:context).doOnListen((){}).doOnCancel((){}).listen((userItem){
                  if(userItem.data!=null){
                    provide.setUserInfoModel(UserInfoModel.fromJson(userItem.data));
                  }
                },onError: (e){});
                UserTools().setUserData(item.data);
              }
              Navigator.pop(context);
              if(pages == 'orderDetail'){
                Navigator.pop(context);
              }
//      _provide
            }, onError: (e) {});
          },
          child: Container(
            height: ScreenAdapter.height(95),
            width: ScreenAdapter.width(595),
            color: Colors.black,
            child: Center(
              child: Text(
                '登录',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenAdapter.size(38)),
              ),
            ),
          ),
        );
      },
    );
  }

  Provide<LoginProvide> _setupRegisteredBtn() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return InkWell(
          onTap: (){
            print('注册被点击');
            Navigator.pushNamed(context, '/regiseredPage');
          },
          child: Container(
            height: ScreenAdapter.height(95),
            width: ScreenAdapter.width(595),
            // color: Colors.black,
            child: Center(
              child: Text(
                '注册',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenAdapter.size(30)),
              ),
            ),
          ),
        );
      },
    );
  }
  Provide<LoginProvide> _setupThirdPartyBtn() {
    return Provide<LoginProvide>(
      builder: (BuildContext context, Widget child, LoginProvide provide) {
        return Container(
          height: ScreenAdapter.height(200),
          width: ScreenAdapter.width(595),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(595),
                height: ScreenAdapter.height(38),
                child: Center(
                  child: Text(
                    '您可以使用第三方登录'
                  ),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.height(40),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(38),
                  ),
                  Container(
                    width: ScreenAdapter.width(95),
                    height: ScreenAdapter.width(95),
                    //color: Colors.yellow,
                    child: Image.asset('assets/images/mall/wechat.jpg',fit: BoxFit.cover,),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: ScreenAdapter.width(95),
                    height: ScreenAdapter.width(95),
                   // color: Colors.yellow,
                    child: Image.asset('assets/images/mall/qq.jpg',fit: BoxFit.cover,),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: ScreenAdapter.width(95),
                    height: ScreenAdapter.width(95),
                    //color: Colors.yellow,
                    child: Image.asset('assets/images/mall/weibo.jpg',fit: BoxFit.cover,),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(38),
                  ),
                ],
              )
            ],
          )
        );
      },
    );
  }
}
