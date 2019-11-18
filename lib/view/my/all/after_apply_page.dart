import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

/// 售后页面
class AfterApplyPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AfterApplyPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterApplyContent(_afterServiceProvide);
  }
}

class AfterApplyContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterApplyContent(this._afterServiceProvide);
  @override
  _AfterApplyContentState createState() => new _AfterApplyContentState();
}

class _AfterApplyContentState extends State<AfterApplyContent> {
  AfterServiceProvide _afterServiceProvide;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}