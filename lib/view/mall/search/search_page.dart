import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
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
  SearchProvide _provide;
  List list = List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context , widget: Container()),
      body:GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: new Container(
          width: double.infinity,
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              _searchHeader(),
              new Container(
                height: ScreenAdapter.height(60),
                alignment: Alignment.centerLeft,
                color: Colors.black26,
                padding: EdgeInsets.only(left: 20),
                child: new Text("为你推荐",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: ScreenAdapter.size(28)),),
              ),
              _recommendTags()
            ],
          ),
        ),
      )
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("初始化数据");
    _provide??=widget._provide;
    _loadData();
  }

  /// 顶部搜索栏
  Widget _searchHeader(){
    return new Container(
      color: AppConfig.assistLineColor,
      margin: EdgeInsets.all(20),
      child: new TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "请输入关键词",
            filled: true,
            prefixIcon: Icon(Icons.search),
            prefixStyle: TextStyle(color: Colors.grey),
            suffix: InkWell(
              onTap: (){},
              child: Padding(padding: EdgeInsets.only(right: 20),
                child: new Text("搜索"),),
            )
        ),
      ),
    );
  }

  /// 推荐标签
  Widget _recommendTags(){
    return IntrinsicHeight(
      child: Wrap(
        spacing: 10,
        children: list.map((item){
          return InkWell(
            onTap: (){
              // 点击搜索
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppConfig.assistLineColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text(item,softWrap: false,style: TextStyle(fontSize: ScreenAdapter.size(26)),),
            ),
          );
        }).toList(),
      ),
    );
  }

  _loadData(){
    _provide.onRecommendedTags()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          list = item.data;
        });
      }
    }, onError: (e) {});
  }
}