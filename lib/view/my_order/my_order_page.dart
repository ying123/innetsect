import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/all_page.dart';
import 'package:innetsect/view/my/cancel/cancel_page.dart';
import 'package:innetsect/view/my/complete/complete_page.dart';
import 'package:innetsect/view/my/for_the_goods/for_the_goods_page.dart';
import 'package:innetsect/view/my/for_the_payment/for_the_payment_page.dart';
import 'package:innetsect/view_model/my_order/my_order_provide.dart';
import 'package:provide/provide.dart';

class MyOrderPage extends PageProvideNode {
  final MyOrderProvide _provide = MyOrderProvide();
  MyOrderPage() {
    mProviders.provide(Provider<MyOrderProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return MyOrderContentPage(_provide);
  }
}

class MyOrderContentPage extends StatefulWidget {
  final MyOrderProvide provide;
  MyOrderContentPage(this.provide);
  @override
  _MyOrderContentPageState createState() => _MyOrderContentPageState();
}

class _MyOrderContentPageState extends State<MyOrderContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('我的订单'),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/xiangxia.png',
                fit: BoxFit.none,
                width: ScreenAdapter.width(38),
                height: ScreenAdapter.width(38),
              )),
          bottom: TabBar(
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 1.0,
            //indicatorPadding: EdgeInsets.all(0.0),
            indicator: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black54))
            ),
            tabs: <Widget>[
              Tab(
                text: '全部',
              ),
              Tab(
                text: '待付款',
              ),
              Tab(
                text: '待收货',
              ),
              Tab(
                text: '已完成',
              ),
              Tab(
                text: '已取消',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AllPage(),
            ForThePaymentPage(),
            ForTheGoodsPage(),
            CompletePage(),
            CancelPage()
          ],
        ),
      ),
    );
  }
}
