import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/coupons/all_coupns_page.dart';
import 'package:innetsect/view/mall/coupons/my_coupons_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
///我的优惠卷页面
class MyCouponsPage extends PageProvideNode {
 final MyCouponsProvide _provide = MyCouponsProvide();
 MyCouponsPage(){
  mProviders.provide(Provider<MyCouponsProvide>.value(_provide))  ;
 }

 @override
  Widget buildContent(BuildContext context) {
   return MyCouponsContentPage(_provide);
  }
}


class MyCouponsContentPage extends StatefulWidget {
  final MyCouponsProvide _provide;
  MyCouponsContentPage(this._provide);
  @override
  _MyCouponsContentPageState createState() => _MyCouponsContentPageState();
}

class _MyCouponsContentPageState extends State<MyCouponsContentPage> {
  MyCouponsProvide _provide;
  @override
  void initState() {
    _provide??= widget._provide;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text('我的优惠卷'),
            elevation: 0.0,
            centerTitle: true,   
              leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              size: ScreenAdapter.size(60),
            ),
          ), 
          bottom: TabBar(
            //isScrollable: true,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.black54,
            indicatorSize:TabBarIndicatorSize.label ,
            indicatorWeight: 1.0,
            indicatorPadding: EdgeInsets.all(0.0),
            indicator: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.blue))
            ),
            tabs: <Widget>[
              Tab(
                text: '可使用',              
              ),
              Tab(
                text: '已使用',              
              ),
              Tab(
                text: '已过期',              
              ),
            ],
          ),    
        ),
        body: TabBarView(
          children: <Widget>[
            AllCoupnsPage(1),
            AllCoupnsPage(2),
            AllCoupnsPage(3),
          ],
          ),
      ),
    );
  }
}