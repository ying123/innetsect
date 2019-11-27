import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';

class EditNickNamePage extends PageProvideNode{
  final LoginProvide _loginProvide = LoginProvide.instance;
  
  EditNickNamePage(){
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
      appBar: CustomsWidget().customNav(context: context, widget: new Text("修改昵称",style: TextStyle(fontSize: ScreenAdapter.size((30)),
        fontWeight: FontWeight.w900)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(right: 10,left: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: userModel.nickName
                  ),
                  onChanged: (val){
                    print(val);
                    setState(() {
                      _nickName = val;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10,right: 10,top: 20),
              child: RaisedButton(
                onPressed: (){
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
  void _editName(){
    print("_nickName--------$_nickName");
    _loginProvide.getVaildNick(_nickName).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        if(item.data['passed']){
          _loginProvide.editUserNick(_nickName).then((item){
            if(item!=null&&item.data){
              UserTools().clearUserInfo();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
                  return LoginPage();
                }
              ));
            }
          });
        }else{
          CustomsWidget().showToast(title: item.data['error']);
        }
      }
    }, onError: (e) {});
  }
}