import 'package:flutter/material.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/after_service_list_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';

/// 我的售后

class AfterServicePage extends StatefulWidget {

  @override
  _AfterServicePageState createState() => new _AfterServicePageState();
}

class _AfterServicePageState extends State<AfterServicePage>
with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(
        context: context,
        elevation: 0.5,
        widget: new Text("我的售后",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900 ),
          ),
        bottom: new TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
            isScrollable: true,
            indicator: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black54))
            ),
            tabs: afterTabBarList.map((item){
              return new Tab(
                child: new Text(item.title),
              );
            }).toList())
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new AfterServiceListPage(idx: 0),
          new AfterServiceListPage(idx: 1),
          new AfterServiceListPage(idx: 2),
          new AfterServiceListPage(idx: 3),
          new AfterServiceListPage(idx: 4)
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}