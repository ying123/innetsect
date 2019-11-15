
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/app.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/view/binding_sign_in/binding_sign_in_page.dart';
import 'package:innetsect/view/home/home_page.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_page.dart';
import 'package:innetsect/view/mall/mall_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/mall/search/search_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/registered/registered_page.dart';

final routes = {
  '/':(context)=>App(),
  '/appNavigationBarPage':(context)=>AppNavigationBar(),
  '/mallPage':(context)=>MallPage(),
  '/mallSearchPage':(context)=>SearchPage(),
  '/commodityPage':(context)=>CommodityPage(),
  '/commodityDetailPage':(context)=>CommodityDetailPage(),
  '/bindingSignIn':(context)=>BindingSignInPage(),
  '/loginPage':(context)=>LoginPage(),
  '/regiseredPage':(context)=>RegisteredPage(),
  '/orderDetailPage':(context)=>OrderDetailPage(),
  '/homePage':(context)=>HomePage()
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  print('settings:->${settings.name}');
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      print('arguments->${settings.arguments}');
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
