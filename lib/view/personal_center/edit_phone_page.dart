import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';
import 'dart:async';


/// 修改手机号
class EditPhonePage extends PageProvideNode{
  final LoginProvide _loginProvide = LoginProvide.instance;

  EditPhonePage(){
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return EditPhoneContent(_loginProvide);
  }
}

class EditPhoneContent extends StatefulWidget {
  final LoginProvide _loginProvide;
  EditPhoneContent(this._loginProvide);
  @override
  _EditPhoneContentState createState() => new _EditPhoneContentState();
}

class _EditPhoneContentState extends State<EditPhoneContent> {
  LoginProvide _loginProvide;

  // 验证码
  bool isButtonEnable = true;
  ///倒计时定时器
  Timer timer;
  int count = 60;
  String buttonText="获取验证码";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Text("更换手机号",style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900)),
      ),
      body: Container(
        width: double.infinity,
        height: ScreenAdapter.getScreenHeight(),
        color: Colors.white,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // 手机号
            Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                ),
                child: _phoneText()
            ),
            // 验证码
            Container(
              margin: EdgeInsets.only(top: 10,left: 20,right: 20),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))
              ),
              child: Stack(
                children: <Widget>[
                  _validCodeText(),
                  new Positioned(
                      top: 0,
                      right: 10,
                      bottom: 2,
                      child: Container(
                        width: ScreenAdapter.width(220),
                        padding: EdgeInsets.only(top: 5,bottom: 5),
                        child: _validCodeBtn(),
                      ))
                ],
              ),
            )

          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(left: 20,right: 20),
        child: RaisedButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: (){
            if(_loginProvide.userCode==null) {
              CustomsWidget().showToast(title: "请输入手机号");
            }else if(_loginProvide.vaildCode==null){
              CustomsWidget().showToast(title: "请输入验证码");
            }else{
              // 请求修改手机号
              _updatePhone();
            }
          },
          child: Text('修改',style: TextStyle(fontSize: ScreenAdapter.size(24),
              fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide ??= widget._loginProvide;
    _loginProvide.userCode = null;
    _loginProvide.vaildCode = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    timer = null;
  }

  /// phone文本
  Provide<LoginProvide> _phoneText(){
    return Provide<LoginProvide>(
        builder: (BuildContext context, Widget child, LoginProvide provide) {
          return new TextField(
            controller: TextEditingController.fromValue(
                TextEditingValue(
                    text: provide.userCode==null?'':provide.userCode,
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: provide.userCode==null?''.length:provide.userCode.length
                    ))
                )),
            enabled: true,
            style: new TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: provide.userCode==null?"请输入手机号":provide.userCode,
                hintStyle: new TextStyle(color: Colors.grey),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),
            onChanged: (str) {
              provide.userCode = str;
            },
          );
        });
  }
  /// 验证码
  Provide<LoginProvide> _validCodeText() {
    return Provide<LoginProvide>(
        builder: (BuildContext context, Widget child, LoginProvide provide) {
          return new TextField(
            controller: TextEditingController.fromValue(
                TextEditingValue(
                    text: provide.vaildCode==null?'':provide.vaildCode,
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: provide.vaildCode==null?''.length:provide.vaildCode.length
                    ))
                )),
            enabled: true,
            style: new TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: provide.vaildCode==null?"请输入验证码":provide.vaildCode,
                hintStyle: new TextStyle(color: Colors.grey),
                focusedBorder: InputBorder.none,
                border: InputBorder.none
            ),
            onChanged: (str) {
              provide.vaildCode = str;
            },
          );
        });
  }
  /// 验证码按钮
  Provide<LoginProvide> _validCodeBtn() {
    return Provide<LoginProvide>(
        builder: (BuildContext context, Widget child, LoginProvide provide) {
          return FlatButton(
            disabledColor: Colors.grey.withOpacity(0.1),
            disabledTextColor: Colors.white,
            textColor: isButtonEnable ? Colors.white : Colors.white,
            color: isButtonEnable
                ? Colors.black
                : Colors.grey.withOpacity(0.8),
            onPressed: () {
              if(provide.userCode==null){
                CustomsWidget().showToast(title: "请输入手机号");
              }else{
                _buttonClickListen(provide);
              }
            },
            child: Text(
              buttonText,
              style: TextStyle(fontSize: ScreenAdapter.size(22)),
            ),
          );
        });
  }


  void  _buttonClickListen(LoginProvide provide) {
    if (isButtonEnable) {
      /// 验证手机号
      _loginProvide.getVaildPhone().doOnListen(() {
        print('doOnListen');
      }).doOnCancel(() {}).listen((item) {
        ///加载数据
        print('listen data->$item');
        if(item!=null&&item.data!=null&&item.data['passed']){
          _loginProvide.getVaildCode().then((items){
            if(items!=null&&items.data){
              setState(() {
                isButtonEnable = false;
              });
              _initTimer();
              CustomsWidget().showToast(title: "验证码已发送");
            }
          });
        }else{
          CustomsWidget().showToast(title: item.data['error']);
        }
      }, onError: (e) {});

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
          buttonText = '重新发送($count)';
        });
      }
    });
  }

  /// 修改手机请求
  void _updatePhone(){
    _loginProvide.editPhone().then((item){
      print(item);
      if(item!=null&&item.data){
        UserInfoModel model = _loginProvide.userInfoModel;
        model.mobile = _loginProvide.userCode;
        CustomsWidget().showToast(title: "修改成功");
        Navigator.pop(context);
      }
    });
  }

}