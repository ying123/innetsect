import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/commodity/list_provide.dart';

class ListPage extends PageProvideNode{
  final ListProvide _provide = ListProvide();
  ListPage(){
    mProviders.provide(Provider<ListProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return ListContent(_provide);
  }
}

class ListContent extends StatefulWidget {
  final ListProvide _provide;
  ListContent(this._provide);

  @override
  _ListContentState createState() => new _ListContentState();
}

class _ListContentState extends State<ListContent> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化数据");
  }
}