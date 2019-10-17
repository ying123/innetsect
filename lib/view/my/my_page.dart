import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my/my_provide.dart';
import 'package:provide/provide.dart';
///我的页面
class MyPage extends PageProvideNode{
  final MyProvide _provide = MyProvide();
  MyPage(){
    mProviders.provide(Provider<MyProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return MyContentPage();
  }
}


class MyContentPage extends StatefulWidget {
  @override
  _MyContentPageState createState() => _MyContentPageState();
}

class _MyContentPageState extends State<MyContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('我的页面'),
      ),
    );
  }
}