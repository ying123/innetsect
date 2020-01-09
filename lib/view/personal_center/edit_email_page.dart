import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';
import 'dart:async';

/// 修改email
class EditEmailPage extends PageProvideNode {
  final LoginProvide _loginProvide = LoginProvide.instance;

  EditEmailPage() {
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return EditEmailContent(_loginProvide);
  }
}

class EditEmailContent extends StatefulWidget {
  final LoginProvide _loginProvide;
  EditEmailContent(this._loginProvide);
  @override
  _EditEmailContentState createState() => new _EditEmailContentState();
}

class _EditEmailContentState extends State<EditEmailContent> {
  LoginProvide _loginProvide;

  // 验证码
  bool isButtonEnable = true;

  ///倒计时定时器
  Timer timer;
  int count = 60;
  String buttonText = "获取验证码";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(
        context: context,
        widget: new Text("换绑邮箱",
            style: TextStyle(
                fontSize: ScreenAdapter.size((30)),
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
            // 电子邮箱
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: _emailText()),
            // 验证码
            Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Stack(
                children: <Widget>[
                  _validCodeText(),
                  new Positioned(
                      top: 0,
                      right: 10,
                      bottom: 2,
                      child: Container(
                        width: ScreenAdapter.width(220),
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: _validCodeBtn(),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: ScreenAdapter.height(120),
        child: Center(
          child: Container(
            width: double.infinity,
            height: ScreenAdapter.height(100),
            color: Colors.white,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                if (_loginProvide.vaildCode == null) {
                  print('换绑定邮箱 按钮被点击');
                  CustomsWidget().showToast(title: "请输入验证码");
                } else {
                  // 请求修改邮箱
                  _updateEmail();
                }
              },
              child: Text(
                '修改',
                style: TextStyle(
                    fontSize: ScreenAdapter.size(24), fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide ??= widget._loginProvide;
    _loginProvide.emailText = null;
    _loginProvide.vaildCode = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    timer = null;
  }

  /// email文本
  Provide<LoginProvide> _emailText() {
    return Provide<LoginProvide>(
        builder: (BuildContext context, Widget child, LoginProvide provide) {
      return new TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
            text: provide.emailText == null ? '' : provide.emailText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: provide.emailText == null
                    ? ''.length
                    : provide.emailText.length)))),
        enabled: true,
        style: new TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: provide.emailText == null ? "请输入邮箱地址" : provide.emailText,
            hintStyle: new TextStyle(color: Colors.grey),
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
        onChanged: (str) {
          provide.emailText = str;
        },
      );
    });
  }

  /// 验证码
  Provide<LoginProvide> _validCodeText() {
    return Provide<LoginProvide>(
        builder: (BuildContext context, Widget child, LoginProvide provide) {
      return new TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
            text: provide.vaildCode == null ? '' : provide.vaildCode,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: provide.vaildCode == null
                    ? ''.length
                    : provide.vaildCode.length)))),
        enabled: true,
        style: new TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: provide.vaildCode == null ? "请输入验证码" : provide.vaildCode,
            hintStyle: new TextStyle(color: Colors.grey),
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
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
        color: isButtonEnable ? Colors.black : Colors.grey.withOpacity(0.8),
        onPressed: () {
          if (provide.emailText == null) {
            CustomsWidget().showToast(title: "请输入电子邮箱");
          } else {
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

  void _buttonClickListen(LoginProvide provide) {
    print('==========>');
    if (isButtonEnable) {
      print('sdfsdfs');

      final String regexEmail =
          "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
      bool isEmail = RegExp(regexEmail).hasMatch(provide.emailText);
      print('isEmail===>$isEmail');
      if (isEmail == false) {
        Fluttertoast.showToast(
          msg: '请输入正确的邮箱',
          gravity: ToastGravity.CENTER
        );
      }else{
         //验证邮箱
      _loginProvide.getEmailValidCode().then((items) {
        if (items != null && items.data) {
          setState(() {
            isButtonEnable = false;
          });
          _initTimer();
          CustomsWidget().showToast(title: "验证码已发送至邮箱");
        }
      });
      }
     

      // _loginProvide.validEmail().doOnListen(() {
      //   print('doOnListen');
      // }).doOnCancel(() {}).listen((item) {
      //   ///加载数据
      //   print('listen data->$item');
      //   if(item!=null&&item.data!=null&&item.data['passed']){
      //     _loginProvide.getEmailValidCode().then((items){
      //       if(items!=null&&items.data){
      //         setState(() {
      //           isButtonEnable = false;
      //         });
      //         _initTimer();
      //         CustomsWidget().showToast(title: "验证码已发送至邮箱");
      //       }
      //     });
      //   }else{
      //     CustomsWidget().showToast(title: item.data['error']);
      //   }
      // }, onError: (e) {});

      // return null;
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

  /// 修改邮箱请求
  void _updateEmail() {
    _loginProvide.editEmail().then((item) {
      if (item != null && item.data) {
        UserInfoModel model = _loginProvide.userInfoModel;
        model.email = _loginProvide.emailText;
        CustomsWidget().showToast(title: "修改成功");
        Navigator.pop(context);
      }
    });
  }
}
