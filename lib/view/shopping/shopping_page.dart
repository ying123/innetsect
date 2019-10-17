import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/shopping/shopping_provide.dart';
import 'package:provide/provide.dart';

class ShoppingPage extends PageProvideNode{
  final ShoppingProvide _provide = ShoppingProvide();
  ShoppingPage(){
    mProviders.provide(Provider<ShoppingProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return ShoppingContentPage();
  }
}

class ShoppingContentPage extends StatefulWidget {
  @override
  _ShoppingContentPageState createState() => _ShoppingContentPageState();
}

class _ShoppingContentPageState extends State<ShoppingContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('购物车'),
      ),
    );
  }
}