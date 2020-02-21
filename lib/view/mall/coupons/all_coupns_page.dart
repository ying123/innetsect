import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/view/mall/coupons/all_coupns_provide.dart';
import 'package:provide/provide.dart';
class AllCoupnsPage extends PageProvideNode{
  final AllCoupnsProvide _provide = AllCoupnsProvide();
  final int index;
  AllCoupnsPage(this.index){
    mProviders.provide(Provider<AllCoupnsProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    
    return AllCoupnsContentPage(_provide,index);
  }
}

class AllCoupnsContentPage extends StatefulWidget {
  final AllCoupnsProvide _provide;
  final int index;
  AllCoupnsContentPage(this._provide, this.index);
  @override
  _AllCoupnsContentPageState createState() => _AllCoupnsContentPageState();
}

class _AllCoupnsContentPageState extends State<AllCoupnsContentPage> {
   AllCoupnsProvide _provide;
   int index;
   @override
  void initState() {
    _provide??= widget._provide;
    index??= widget.index;

    print('index=======>$index');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}