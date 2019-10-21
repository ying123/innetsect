import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/view_model/my/cancel/cancel_provide.dart';
import 'package:provide/provide.dart';
class CancelPage extends PageProvideNode{
  final CancelProvide _provide = CancelProvide();
  CancelPage(){
    mProviders.provide(Provider.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
  
    return CancelContentPage();
  }
}

class CancelContentPage extends StatefulWidget {
  @override
  _CancelContentPageState createState() => _CancelContentPageState();
}

class _CancelContentPageState extends State<CancelContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('取消'),
      ),
    );
  }
}