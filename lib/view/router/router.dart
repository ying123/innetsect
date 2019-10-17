import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/app.dart';
import 'package:innetsect/view/home/home_page.dart';

final routes = {
  '/':(context)=>App(),
  '/homePage':(context)=>HomePage(),
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
