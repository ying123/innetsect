import 'package:flutter/material.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/base/base.dart';

class AfterServicePage extends PageProvideNode{

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterServiceContent();
  }
}

class AfterServiceContent extends StatefulWidget {
  @override
  _AfterServiceContentState createState() => new _AfterServiceContentState();
}

class _AfterServiceContentState extends State<AfterServiceContent>
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
          new Text("1"),
          new Text("2"),
          new Text("2"),
          new Text("2"),
          new Text("2")
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

  @override
  void didUpdateWidget(AfterServiceContent oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}