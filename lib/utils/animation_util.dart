import 'package:flutter/material.dart';
///常用动画曲线获取
class AnimationUtil{

///获取底部进场动画
 static Tween<Offset> getBottominAnilmation(){
   return Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
}
///获取顶部进场动画
  static Tween<Offset> getTopInAnilmation(){
    return Tween(begin: Offset(0.0, -1.0), end: Offset.zero);
  }
}