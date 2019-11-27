import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/brand_mall_model.dart';
import 'package:innetsect/view/brand/brand_mall_provide.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BrandMallPage extends PageProvideNode {
  final BrandMallPrvide _prvide = BrandMallPrvide();
  String brandName;
  BrandMallPage(this.brandName) {
    mProviders.provide(Provider<BrandMallPrvide>.value(_prvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BrandMallContentPage(_prvide, brandName);
  }
}

class BrandMallContentPage extends StatefulWidget {
  final BrandMallPrvide _prvide;
  String brandName;
  BrandMallContentPage(this._prvide,this.brandName);
  @override
  _BrandMallContentPageState createState() => _BrandMallContentPageState();
}

class _BrandMallContentPageState extends State<BrandMallContentPage> {
   BrandMallPrvide _prvide;
   String brandName;
   ///控制器
  EasyRefreshController _controller;
    int pageNo = 1;
   @override    
   void initState() { 
     super.initState();
     _prvide??= widget._prvide;
    brandName??=widget.brandName;
     _initBrandMallData();
   }
  _initBrandMallData(){
    _prvide.brandMallData(brandName, pageNo).doOnListen((){

    }).doOnError((e,stack){

    }).listen((items){
      print('brandMallitems=============>${items.data}');
      if (items.data != null) {
        _prvide.addBrandMall(BrandMallModelList.fromJson(items.data).list);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('品牌商城'),
      //   centerTitle: true,
      // ),
      body: ListWidgetPage(

      ),
    );
  }
}
