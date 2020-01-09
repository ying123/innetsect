import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';

class EditNickNamePage extends PageProvideNode {
  final LoginProvide _loginProvide = LoginProvide.instance;

  EditNickNamePage() {
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return EditNickNameContent(_loginProvide);
  }
}

class EditNickNameContent extends StatefulWidget {
  final LoginProvide _loginProvide;
  EditNickNameContent(this._loginProvide);
  @override
  _EditNickNameContentState createState() => new _EditNickNameContentState();
}

class _EditNickNameContentState extends State<EditNickNameContent> {
  LoginProvide _loginProvide;
  String _nickName;

  @override
  Widget build(BuildContext context) {
    UserInfoModel userModel = _loginProvide.userInfoModel;
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          '修改昵称',
        ),
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
      body: Center(
        child: Column(
          children: <Widget>[
            new IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: TextField(
                  controller: TextEditingController.fromValue(TextEditingValue(
                      text:
                          userModel.nickName == null ? '' : userModel.nickName,
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: userModel.nickName.toString().length)))),
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(
                        "[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")), //只能输入汉字或者字母或数字
                  ],
                  maxLength: 30,
                  maxLengthEnforced: true,
                  onChanged: (val) {
                    print(val);
                    userModel.nickName = val;
                    setState(() {
                      _nickName = val;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: RaisedButton(
                onPressed: () {
                  // 修改昵称
                  _editName();
                },
                textColor: Colors.white,
                color: Colors.black,
                child: new Text("修改"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide ??= widget._loginProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /// 修改昵称
  void _editName() {
    print("_nickName--------$_nickName");
    UserInfoModel userModel = _loginProvide.userInfoModel;
    if (userModel.nickName == '' || userModel.nickName == null) {
      Fluttertoast.showToast(msg: '昵称不能为空', gravity: ToastGravity.CENTER);
    } else {
      _loginProvide
          .getVaildNick(_nickName)
          .doOnListen(() {
            print('doOnListen');
          })
          .doOnCancel(() {})
          .listen((item) {
            ///加载数据
            print('listen data->$item');
            if (item != null && item.data != null) {
              if (item.data['passed']) {
                _loginProvide.editUserNick(_nickName).then((item) {
                  if (item != null && item.data) {
                    CustomsWidget().showToast(title: "修改成功");
                    UserTools().clearUserInfo();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  }
                });
              } else {
                CustomsWidget().showToast(title: item.data['error']);
              }
            }
          }, onError: (e) {});
    }
  }
}
