import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/binding_sign_in/binding_sign_in_proivde.dart';
import 'package:provide/provide.dart';

class BindingSignInPage extends PageProvideNode {
  final BingdingSignInProvide _provide = BingdingSignInProvide();
  BindingSignInPage(){
    mProviders.provide(Provider<BingdingSignInProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    
    return BindingSignInContentPage();
  }
}

class BindingSignInContentPage extends StatefulWidget {
  @override
  _BindingSignInContentPageState createState() => _BindingSignInContentPageState();
}

class _BindingSignInContentPageState extends State<BindingSignInContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('绑定签到'),
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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: ScreenAdapter.width(110),top: ScreenAdapter.height(290),),
            child: Container(
              width: ScreenAdapter.width(528),
              height: ScreenAdapter.height(715),
             // color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenAdapter.height(112),
                  ),
                  Text('二维码一分钟内有效',style: TextStyle(fontSize: ScreenAdapter.size(40)),),
                  SizedBox(
                    height: ScreenAdapter.height(60),
                  ),
                  Container(
                    width: ScreenAdapter.width(377),
                    height: ScreenAdapter.height(377),
                    child: Image.asset('assets/images/erweima.png'),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Color.fromRGBO(242, 243, 245, 1.0),blurRadius: 3, spreadRadius: 3)]
              ),
            ),
          )
        ],
      ),
    );
  }
}