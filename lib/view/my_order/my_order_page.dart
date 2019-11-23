import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/all_page.dart';
import 'package:innetsect/view_model/mall/logistics/logistics_provide.dart';
import 'package:innetsect/view_model/my_order/my_order_provide.dart';
import 'package:provide/provide.dart';

class MyOrderPage extends PageProvideNode {
  final MyOrderProvide _provide = MyOrderProvide();
  final LogisticsProvide _logisticsProvide = LogisticsProvide.instance;
  MyOrderPage() {
    mProviders.provide(Provider<MyOrderProvide>.value(_provide));
    mProviders.provide(Provider<LogisticsProvide>.value(_logisticsProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return MyOrderContentPage(_provide,_logisticsProvide);
  }
}

class MyOrderContentPage extends StatefulWidget {
  final MyOrderProvide provide;
  final LogisticsProvide _logisticsProvide;
  MyOrderContentPage(this.provide,this._logisticsProvide);
  @override
  _MyOrderContentPageState createState() => _MyOrderContentPageState();
}

class _MyOrderContentPageState extends State<MyOrderContentPage> {
  LogisticsProvide _logisticsProvide;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('我的订单',style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900)),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
//                Navigator.popAndPushNamed(context, "/appNavigationBarPage");
              },
              child: new Container(
                  padding: EdgeInsets.all(20),
                  color:Colors.deepOrangeAccent,
                  child: new Image.asset("assets/images/mall/arrow_down.png",
                    fit: BoxFit.fitWidth,
                  )
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
            AllPage(idx: 0),
            AllPage(idx: 1),
            AllPage(idx: 2),
            AllPage(idx: 3),
            AllPage(idx: 4)
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logisticsProvide ??= widget._logisticsProvide;
    _logisticsProvide.backPage = "/myOrderPage";
  }
}
