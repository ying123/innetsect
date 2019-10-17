import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_provide.dart';

class CommodityPage extends PageProvideNode{
  final CommodityProvode _provide = CommodityProvode();
  MallPage(){
    mProviders.provide(Provider<CommodityProvode>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return CommodityContent(_provide);
  }
}

class CommodityContent extends StatefulWidget {
  final CommodityProvode _provide;

  CommodityContent(this._provide);

  @override
  _CommodityContentState createState() => new _CommodityContentState();
}

class _CommodityContentState extends State<CommodityContent> {

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Center(child: new Text("首页"),)
        ],
      ),
    );
  }
}