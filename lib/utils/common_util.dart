

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CommonUtil{

  static String appTitle = 'innersect3';

  static const int cmd_user_setting = 100;


///匹配密码格式正确返回true
  static isPassword(String password) {
    return new RegExp(r'^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$').hasMatch(password);
  }
  ///匹配email格式正确返回true
  static isEmail(String email) {
    return new RegExp(r'^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$').hasMatch(email);
  }
///隐藏状态栏简单
  static hideStatusbarEasy(){
    SystemChrome.setEnabledSystemUIOverlays([]);
  }


///通过动画曲线创建界面  
static Route createRoute(Tween<Offset> tween, Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      });
}

  /// 商品skuname截取显示
  static List skuNameSplit(String skuName){
    List list = List();
    if(skuName.indexOf(":")>0){
      list = skuName.split(":");
    }
    return list;
  }

  /// 售后状态
  /// *[状态：10 申请中 30已审核通过 34审核不通过 35已退货 40已收到退货 50已完成 60 已协商取消 61验货不通过 -1用户取消]
  static String afterStatusName(int status){
    String name;
    switch(status){
      case 10:
        name = "申请中";
        break;
      case 30:
        name = "已审核通过";
        break;
      case 34:
        name ="审核不通过";
        break;
      case 35:
        name = "已退货";
        break;
      case 40:
        name = "已收到退货";
        break;
      case 50:
        name="已完成";
        break;
      case 60:
        name="已协商取消";
        break;
      case 61:
        name="验货不通过";
        break;
      case -1:
        name="退货已取消";
        break;
    }
    return name;
  }

}