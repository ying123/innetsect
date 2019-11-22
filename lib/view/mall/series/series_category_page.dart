import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/series/category_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/search/search_page.dart';
import 'package:innetsect/view/mall/series/series_category_child_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/series/series_provide.dart';
import 'package:provide/provide.dart';

class SeriesCategoryPage extends PageProvideNode{
  
  final SeriesProvide _seriesProvide = SeriesProvide.instance;

  SeriesCategoryPage(){
    mProviders.provide(Provider<SeriesProvide>.value(_seriesProvide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SeriesCategoryContent(_seriesProvide);
  }
  
}

class SeriesCategoryContent extends StatefulWidget {
  final SeriesProvide _seriesProvide;
  
  SeriesCategoryContent(this._seriesProvide);
  @override
  _SeriesCategoryContentState createState() => _SeriesCategoryContentState();
}

class _SeriesCategoryContentState extends State<SeriesCategoryContent> with TickerProviderStateMixin{
  SeriesProvide _seriesProvide;
  List<CategoryModel> _list = [];

  //顶部导航
  TabController _tabController;
  // 是否初始化tab切换
  bool isInitTabChange = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(88.0)
          ),
          child: _tabBarRootNav(),
        ),
        Positioned(
          top: 5,
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(20*ScreenAdapter.getPixelRatio()),
          child: CustomsWidget().searchWidget(
            onTap: (){
              // 跳转搜索
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return SearchPage();
                }
              ));
            }
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesProvide ??= widget._seriesProvide;
    _initLoadData();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  /// 初始化数据
  void _initLoadData(){
    _seriesProvide.getCateGoryRoot().doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
        List<CategoryModel> lists = CategoryModelList.fromJson(items.data).list;

        setState(() {
          _list = lists;
        });


        _tabController = TabController(vsync: this,length: _list.length);
      }

    }, onError: (e) {});
  }

  /// 顶部导航
  Widget _tabBarRootNav(){
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      child: _list.length>0? Column(
        children: <Widget>[
          new SizedBox(
            width: double.infinity,
            height: ScreenAdapter.height(80),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorColor: AppConfig.blueBtnColor,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: new TextStyle(fontSize: 14.0),
              labelColor: Colors.black,
              labelStyle: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _list.map((item){
                return Tab(
                  text: item.catName,
                );
              }).toList(),
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: new TabBarView(
                  controller: _tabController,
                  children:  _list.map((item){
                      return new SeriesCategoryChildPage(model: item);
                  }).toList()
              ),
            ),
          )
        ],
      ):Container(),
    );
  }
}
