import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/brand/brand_provide.dart';
import 'package:provide/provide.dart';
 
class BrandPage extends PageProvideNode{
  final BrandProvide _provide = BrandProvide();
  BrandPage(){
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

class _BrandContentPageState extends State<BrandContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('品牌')),
    );
  }
}