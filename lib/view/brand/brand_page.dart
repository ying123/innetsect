import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/brand/venues/a_venued_page.dart';
import 'package:innetsect/view/brand/venues/b_venued_page.dart';
import 'package:innetsect/view/brand/venues/c_venued_page.dart';
import 'package:innetsect/view_model/brand/brand_provide.dart';
import 'package:provide/provide.dart';

class BrandPage extends PageProvideNode {
  final BrandProvide _provide = BrandProvide();
  BrandPage() {
    mProviders.provide(Provider<BrandProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BrandContentPage();
  }
}

class BrandContentPage extends StatefulWidget {
  @override
  _BrandContentPageState createState() => _BrandContentPageState();
}

class _BrandContentPageState extends State<BrandContentPage>
    with SingleTickerProviderStateMixin {
  var controller;
  var tabs = <Tab>[
    Tab(
      text: 'A馆',
    ),
    Tab(
      text: 'B馆',
    ),
    // Tab(
    //   text: 'C馆',
    // ),
  ];

  @override
  void initState() {
    controller = TabController(
      length: tabs.length,
      vsync: this,//动画效果的异步处理， 默认格式
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Container(),
          title: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black54 ,
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.label,

           // labelPadding: EdgeInsets.only(left: 20),
           //indicatorPadding: EdgeInsets.only(bottom: 1.0),
           labelStyle: TextStyle(
             fontSize: ScreenAdapter.size(35)
           ),
            tabs:tabs,
            controller: controller,
          ),
          centerTitle: true,
        ),

        body: TabBarView(
          controller: controller,
          children: <Widget>[
            AVenuedPage(),
            BVenuedPage(),
           // CVenuedPage()
          ],
        ),
      ),
      
    );
  }
}
