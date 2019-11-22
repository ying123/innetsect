import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/series/series_azlist_page.dart';
import 'package:innetsect/view/mall/series/series_category_page.dart';

/// 分类入口
class SeriesMainPage extends StatefulWidget {
  @override
  _SeriesMainPageState createState() => _SeriesMainPageState();
}

class _SeriesMainPageState extends State<SeriesMainPage> with TickerProviderStateMixin{
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _tabBar(),
        elevation:0.0,
        centerTitle: true,
        automaticallyImplyLeading:false,
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new SeriesAzListPage(),
          new SeriesCategoryPage()
        ]),
    );
  }

  Widget _tabBar(){
    return new Container(
      width: ScreenAdapter.getScreenWidth()/3,
      child: new TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: AppConfig.blueBtnColor,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: new TextStyle(fontSize: 14.0),
          labelColor: Colors.black,
          labelStyle: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: seriesTabBarList.map((item){
            return new Tab(
              text: item.title,
            );
          }).toList()
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: seriesTabBarList.length, vsync: this);
  }
}
