import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/platform_menu_config.dart';

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
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Text("1"),
          new Text("2")
        ]),
    );
  }

  Widget _tabBar(){
    return new TabBar(
      controller: _tabController,
      isScrollable: false,
      indicatorColor: AppConfig.blueBtnColor,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: new TextStyle(fontSize: 14.0),
      labelColor: Colors.black,
      labelStyle: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
      tabs: seriesTabBarList.map((item){
        return new Container(
          child: new Text(item.title,maxLines: 1,),
        );
      }).toList()
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }
}
