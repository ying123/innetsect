import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';

/// 搜索页面
class SearchPage extends PageProvideNode{
  final SearchProvide _provide = SearchProvide();
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  SearchPage(){
    mProviders.provide(Provider<SearchProvide>.value(_provide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return SearchContent(_provide,_commodityListProvide);
  }
}

class SearchContent extends StatefulWidget {
  final SearchProvide _provide;
  final CommodityListProvide _commodityListProvide;
  SearchContent(this._provide,this._commodityListProvide);

  @override
  _SearchContentState createState() => new _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  SearchProvide _provide;
  CommodityListProvide _commodityListProvide;
  List _list = List();
  List _historyList = List();
  TextEditingController _selectionController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context , widget: Container()),
      body:GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: new Container(
            width: double.infinity,
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                _searchHeader(),
                _historyList==null?Container():
                new Container(
                  height: ScreenAdapter.height(60),
                  alignment: Alignment.centerLeft,
                  color: Colors.black26,
                  padding: EdgeInsets.only(left: 20),
                  child: new Text("搜索历史",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: ScreenAdapter.size(28)),),
                ),
                _historyList==null?Container():_historyTags(),
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
    _commodityListProvide ??= widget._commodityListProvide;
    _loadData();

    _historyList = UserTools().getSearchHistory();
  }

  /// 顶部搜索栏
  Provide<SearchProvide> _searchHeader(){
    return Provide<SearchProvide>(
      builder: (BuildContext context,Widget widget,SearchProvide provide){
        return new Container(
          color: AppConfig.assistLineColor,
          margin: EdgeInsets.all(20),
          child: new TextField(
            controller: _selectionController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入关键词",
              filled: true,
              prefixIcon: Icon(Icons.search),
              prefixStyle: TextStyle(color: Colors.grey),
              suffix: InkWell(
                onTap: (){
                  // 搜索
                  if(provide.searchValue==null){
                    CustomsWidget().showToast(title: "请输入关键词");
                    return;
                  }

                  // 存储搜索记录
                  UserTools().saveSearchHistory(provide.searchValue);
                  setState(() {
                    _historyList = UserTools().getSearchHistory();
                  });
                  _searchRequest(provide.searchValue);
                },
                child: Padding(padding: EdgeInsets.only(right: 20),
                  child: new Text("搜索"),),
              ),
            ),
            onChanged: (val){
              provide.searchValue = val;
            },
          ),
        );
      },
    );
  }

  /// 推荐标签
  Provide<SearchProvide> _recommendTags(){
    return Provide<SearchProvide>(
      builder: (BuildContext context,Widget widget,SearchProvide provide){
        return _list.length>0 ?Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Wrap(
            spacing: 10,
            children: _list.map((item){
              return InkWell(
                onTap: (){
                  // 点击搜索
                  provide.searchValue = item;
                  _selectionController.text = item;
                  // 存储搜索记录
                  UserTools().saveSearchHistory(provide.searchValue);
                  setState(() {
                    _historyList = UserTools().getSearchHistory();
                  });
                  _searchRequest(provide.searchValue);
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
        ):new Container();
      },
    );
  }

  /// 历史记录
  Provide<SearchProvide> _historyTags(){
    return Provide<SearchProvide>(
      builder: (BuildContext context,Widget widget,SearchProvide provide){
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
          child: Wrap(
            spacing: 10,
            children: _historyList.map((item){
              return InkWell(
                onTap: (){
                  // 点击搜索
                  provide.searchValue = item;
                  _selectionController.text = item;
                  _searchRequest(provide.searchValue);
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
      },
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
          _list = item.data;
        });
      }
    }, onError: (e) {});
  }

  /// 搜索请求
  void _searchRequest(String name){
    // 清除原数据
    _commodityListProvide.clearList();
    _commodityListProvide.requestUrl = "/api/eshop/app/products/search?words=$name";
    _provide.onSearch(_commodityListProvide.requestUrl+'&pageNo=1&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
      }

    }, onError: (e) {});

    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return SearchScreenPage();
        }
    ));
  }
}