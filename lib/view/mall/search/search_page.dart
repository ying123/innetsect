import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';

class SearchPage extends PageProvideNode{
  final SearchProvide _provide = SearchProvide();
  SearchPage(){
    mProviders.provide(Provider<SearchProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return SearchContent(_provide);
  }
}

class SearchContent extends StatefulWidget {
  final SearchProvide _provide;
  SearchContent(this._provide);

  @override
  _SearchContentState createState() => new _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("搜索页"),
      ),
      body: new Stack(
        children: <Widget>[
          new Positioned(
              top:0,
              child: new Text("搜索页"))
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化数据");
  }
}