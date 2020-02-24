import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/settings/protocol_page.dart';
import 'package:innetsect/view/registered/country_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/registered/registered_provide.dart';
import 'package:provide/provide.dart';

class RegisteredPage extends PageProvideNode {
  final RegisteredProvide _registeredProvide = RegisteredProvide.instance;
  final LoginProvide _loginProvide = LoginProvide.instance;
  RegisteredPage() {
    mProviders.provide(Provider<RegisteredProvide>.value(_registeredProvide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return RegidterContentPage(_registeredProvide,_loginProvide);
  }
}

class RegidterContentPage extends StatefulWidget {
  final RegisteredProvide _registeredProvide;
  final LoginProvide _loginProvide;
  RegidterContentPage(this._registeredProvide,this._loginProvide);
  @override
  _RegidterContentPageState createState() => _RegidterContentPageState();
}

class _RegidterContentPageState extends State<RegidterContentPage> {
  ///文本编辑控制器
  TextEditingController mController = TextEditingController();
  LoginProvide _loginProvide;
  RegisteredProvide _registeredProvide;

  ///倒计时定时器
  Timer timer;

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    _registeredProvide.userCode=null;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 清空token
    UserTools().clearUserInfo();
    _loginProvide ??=widget._loginProvide;
    _registeredProvide ??= widget._registeredProvide;
    if(timer!=null){
      timer?.cancel();
      timer = null;
    }
    _registeredProvide.userCode=null;
    _registeredProvide.isButtonEnable = true;
    _registeredProvide.count = 60;
    _registeredProvide.buttonText = '获取验证码';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('注册'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              SizedBox(
                height: ScreenAdapter.height(180),
              ),
              //注册
              _setupTextFields(),
              SizedBox(
                height: ScreenAdapter.height(545),
              ),
              //勾选条款
              _setupAgreeTerms(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(166),
        child: _registerBtn(),
      ),
    );
  }

  Widget _setupTextFields() {
    return new Column(
      children: _setupContent(),
    );
  }

  List<Widget> _setupContent() {
    return new List<Widget>.generate(
        2, (int index) => _setupItem(index));
  }

  Widget _setupItem(int index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.fromLTRB(
            ScreenAdapter.width(70), 0, ScreenAdapter.width(70), 0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  flex:2,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return CountryPage();
                        }
                      ));
                    },
                    child: Provide<RegisteredProvide>(
                      builder: (BuildContext context, Widget child, RegisteredProvide provide){
                        return Container(
                          child: Row(
                            children: <Widget>[
                              Text('+ ${provide.telPrefix}'),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ),
                new Expanded(
                  flex: 6,
                  child: Provide<RegisteredProvide>(
                    builder: (BuildContext context, Widget child, RegisteredProvide provide){
                      return new TextField(
                          enabled: true,
                          style: new TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: provide.placeHoderText[index],
                              hintStyle: new TextStyle(color: Colors.grey),
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none
                          ),
                          onChanged: (str) {
                            provide.userCode = str;
                          },
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: provide.userCode==null?'':provide.userCode,
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: provide.userCode.toString().length
                                  ))
                              ))
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              // border: Border(bottom: BorderSide(color: Colors.grey))
              ),
          margin: EdgeInsets.fromLTRB(
              ScreenAdapter.width(70), 10, ScreenAdapter.width(70), 0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: Provide<RegisteredProvide>(
                      builder: (BuildContext context, Widget child, RegisteredProvide provide){
                        return new TextField(
                          enabled: true,
                          style: new TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: provide.placeHoderText[index],
                            hintStyle: new TextStyle(color: Colors.grey),
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (str) {
                            provide.vaildCode = str;
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        new Positioned(
            top: 0,
            right: 60,
            child: Container(
              width: ScreenAdapter.width(220),
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: Provide<RegisteredProvide>(
                builder: (BuildContext context, Widget child, RegisteredProvide provide){
                  return FlatButton(
                    disabledColor: Colors.grey.withOpacity(0.1),
                    disabledTextColor: Colors.white,
                    textColor:
                    provide.isButtonEnable ? Colors.white : Colors.white,
                    color: provide.isButtonEnable
                        ? Colors.black
                        : Colors.grey.withOpacity(0.8),
                    onPressed: () {
                      if(provide.userCode==null){
                        CustomsWidget().showToast(title: "请输入账号");
                      }else{
                        if(provide.telPrefix=='86'
                            ||provide.telPrefix=='853'
                            ||provide.telPrefix=='886'
                            ||provide.telPrefix=='852'){
                          bool flag = CommonUtil.isPhoneLegal(provide.userCode);
                          if(!flag){
                            CustomsWidget().showToast(title: "请输入正确的手机号");
                            return;
                          }
                        }
                        _buttonClickListen();
                      }
                    },
                    child: Text(
                      provide.buttonText,
                      style: TextStyle(fontSize: ScreenAdapter.size(22)),
                    ),
                  );
                },
              ),
            )
        )
      ],
    );
  }

  /// 注册按钮
  Widget _registerBtn(){
    return Center(
      child: InkWell(
        onTap: (){
          print('注册按钮被点击');
          if(_registeredProvide.userCode==null){
            CustomsWidget().showToast(title: "请输入账号");
          }else
          if(!_registeredProvide.checkSelected){
            CustomsWidget().showToast(title: "是否同意注册并遵守服务条款");
          }else
          if(_registeredProvide.vaildCode==null){
            CustomsWidget().showToast(title: "请输入验证码");
          }else{
            _onRegistered();
          }
        },
        child: Container(
          width: ScreenAdapter.width(705),
          height: ScreenAdapter.height(95),
          color: Colors.black,
          child: Center(
            child: Text(
              '注册',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenAdapter.size(38)),
            ),
          ),
        ),
      ),
    );
  }

  _buttonClickListen() {
    if (_registeredProvide.isButtonEnable) {
      /// 验证手机号是否注册过
      _registeredProvide.registeredPhone().doOnListen(() {
        print('doOnListen');
      }).doOnCancel(() {}).listen((item) {
        ///加载数据
        print('listen data->$item');
        if (item != null && item.data != null) {
          if (item.data['passed']) {
            _sendValidCode();

            setState(() {
              _registeredProvide.isButtonEnable = false;
            });
            _initTimer();
          } else {
            CustomsWidget().showToast(title: item.data['error']);
          }
        }
      });

      return null;
    } else {
      return null;
    }
  }

  /// 发送验证码
  void _sendValidCode() async{
    _loginProvide.userCode = _registeredProvide.userCode;
    await _loginProvide.getVaildCode().then((item){
      if(item!=null&&item.data){
        CustomsWidget().showToast(title: "验证码已发送");
      }
    });
  }

  void _initTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _registeredProvide.count--;

      if (_registeredProvide.count == 0) {
        timer.cancel();
        _registeredProvide.isButtonEnable = true;
        _registeredProvide.count = 60;
        _registeredProvide.buttonText = '获取验证码';
      } else {
        _registeredProvide.buttonText = '重发(${_registeredProvide.count})';
      }
    });
  }

  Provide<RegisteredProvide> _setupAgreeTerms() {
    return Provide<RegisteredProvide>(
      builder: (BuildContext context, Widget child, RegisteredProvide provide) {
        return Container(
          width: ScreenAdapter.width(705),
          height: ScreenAdapter.height(95),
        //  color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Checkbox(
                checkColor: Colors.white,
                value: provide.checkSelected,
                activeColor: Colors.black,
                onChanged: (value) {
                  provide.checkSelected = value;
                },
              ),
              
              Center(child:
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return ProtocolPage(title: "innersect用户协议",leading: true,);
                        }
                    ));
                  },
                  child: Text('注册即代表同意INNERSECT服务条款',style: TextStyle(fontSize: ScreenAdapter.size(28)),)),
                )

            ],
          ),
        );
      },
    );
  }

  /// 注册请求
  void _onRegistered(){
    _registeredProvide.onRegistered(_registeredProvide.vaildCode,
    _registeredProvide.telPrefix,_registeredProvide.userCode).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        Navigator.pop(context);
        CustomsWidget().showToast(title: "注册成功");
      }
    }, onError: (e) {});
  }
}
