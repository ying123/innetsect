

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




}