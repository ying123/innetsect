import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/binding_sign_in/sortilege_page.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/my/settings/about_us_page.dart';
import 'package:innetsect/view/my/settings/edit_pwd_page.dart';
import 'package:innetsect/view/personal_center/personal_center_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/mall/user/user_provide.dart';
import 'package:provide/provide.dart';

class MySettingsPage extends PageProvideNode{
  final UserProvide _provide = UserProvide();
  final LoginProvide _loginProvide = LoginProvide.instance;
  final String page;
  MySettingsPage({this.page}){
    mProviders.provide(Provider<UserProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return MySettingsContent(_loginProvide,page: page,);
  }
}

class MySettingsContent extends StatefulWidget {
  final LoginProvide _loginProvide;
  final String page;
  MySettingsContent(this._loginProvide,{this.page});
  @override
  _MySettingsContentState createState() => new _MySettingsContentState();
}

class _MySettingsContentState extends State<MySettingsContent> {
  LoginProvide _loginProvide;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("个人设置")),
      body: new Container(
        width: double.infinity,
        child: new Column(
          children: <Widget>[
            // 个人资料
            _listWidgets(icon: Icons.account_circle,title: "个人资料",onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return PersonalCenterPage();
                  }
              ));
            }),
            new Divider(height: 1,indent: 10,endIndent: 10,color: AppConfig.assistLineColor,),
            // 抽签登记
            widget.page=="exhibition"?
            _listWidgets(icon: Icons.book,title: "抽签登记信息",onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return SortilegePage(pages: "mySetting",);
                  }
              ));
            }):Container(width: 0,height: 0,),
            new Divider(height: 1,indent: 10,endIndent: 10,color: AppConfig.assistLineColor,),
            // 修改密码
            _listWidgets(icon: Icons.lock_outline,title: "修改密码",onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return EditPwdPage();
                }
              ));
            }),
            new Divider(height: 1,indent: 10,endIndent: 10,color: AppConfig.assistLineColor,),
            _listWidgets(icon: Icons.supervised_user_circle, title: "关于我们",onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return AboutUsPage();
                  }
              ));
            }),
            // 退出登录
            _loginOutWidget()
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide = widget._loginProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _listWidgets({Function() onTap,
    IconData icon,
    String title
  }){
    return new InkWell(
      onTap: (){
        onTap();
      },
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              child:new Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(title),
                  )
                ],
              ),
            ),
            new Container(
              child: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }

  /// 退出登录
  Widget _loginOutWidget(){
    return new InkWell(
      onTap: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return new AlertDialog(
                content: new Container(
                  child: new Text("是否确认退出当前账户"),
                ),
                actions: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new FlatButton(
                        color:Colors.white,
                        textColor: Colors.blue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("取消"),
                      ),
                      new FlatButton(
                        color:Colors.white,
                        textColor: Colors.blue,
                        onPressed: () {
                          UserTools().clearUserInfo();
                          _loginProvide.clearUserInfoModel();
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=> LoginPage()
                          ));
                        },
                        child: new Text("确认"),
                      )
                    ],
                  )
                ],
              );
            }
        );
      },
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 20,bottom: 20),
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 20),
        child: new Text("退  出  登  录",style: TextStyle(color: AppConfig.blueBtnColor,
            fontSize: ScreenAdapter.size(28)),),
      ),
    );
  }
}