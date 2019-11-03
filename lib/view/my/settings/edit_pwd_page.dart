import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/user/user_provide.dart';
import 'package:provide/provide.dart';

class EditPwdPage extends PageProvideNode{
  final UserProvide _provide = UserProvide();

  EditPwdPage(){
    mProviders.provide(Provider<UserProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return EditPwdContent(_provide);
  }

}

class EditPwdContent extends StatefulWidget {
  final UserProvide _provide;
  EditPwdContent(this._provide);

  @override
  _EditPwdContentState createState() => new _EditPwdContentState();
}

class _EditPwdContentState extends State<EditPwdContent> {

  String newPwd;
  String reNewPwd;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("修改密码")),
      body: new Stack(
        children: <Widget>[
          new Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(80),
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "请输入新密码"
                      ),
                      onChanged: (text){
                        setState(() {
                          newPwd = text;
                        });
                      },
                    ),
                  ),
                  new Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(80),
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "请再次输入新密码"
                      ),
                      onChanged: (text){
                        setState(() {
                          reNewPwd = text;
                        });
                      },
                    ),
                  )
                ],
              )
          ),
          new Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: new InkWell(
                onTap: (){
                  // 验证两次密码一致
                  if(newPwd!=reNewPwd){
                    Fluttertoast.showToast(msg: "两次输入密码不一致！");
                    return;
                  }
                  // 修改密码请求
                },
                child: new Container(
                  height: ScreenAdapter.height(60),
                  alignment: Alignment.center,
                  color: Colors.black,
                  margin: EdgeInsets.all(20),
                  width: ScreenAdapter.getScreenWidth()-200,
                  child: new Text("修  改  密  码",style: TextStyle(color: Colors.white),),
                ),
              )
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(EditPwdContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}