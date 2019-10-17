import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/mall/mall_provide.dart';
import 'package:provide/provide.dart';
///商城页面
class MallPage extends PageProvideNode{
 final MallProvode _provode = MallProvode();
  MallPage(){
    mProviders.provide(Provider<MallProvode>.value(_provode));
  }
  @override
  Widget buildContent(BuildContext context) {
  
    return MallContentPage();
  }
}

class MallContentPage extends StatefulWidget {
  @override
  _MallContentPageState createState() => _MallContentPageState();
}

class _MallContentPageState extends State<MallContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('商城'),
      ),
    );
  }
}